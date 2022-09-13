import 'package:barcode/barcode.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Payment"),
        backgroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: currentPage,
        onTap: (int index) {
          pageController.jumpToPage(index);
          setState(() => currentPage = index);
        },
        items: const [
          BottomBarItem(
            icon: Icon(
              Icons.qr_code,
            ),
            title: Text('Pix'),
            activeColor: Colors.deepOrangeAccent,
          ),
          BottomBarItem(
            icon: Icon(
              Icons.bar_chart,
            ),
            title: Text('Boleto'),
            activeColor: Colors.deepOrangeAccent,
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        allowImplicitScrolling: false,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _PaymentMethod(
            paymentTitle: "Pix",
            buttonTitle: "Copiar código Pix",
            buttonCallback: () {},
            display: const _QrCode(),
          ),
          _PaymentMethod(
            paymentTitle: "Boleto",
            buttonTitle: "Copiar código de barras",
            buttonCallback: () {},
            display: const _BarcodeWidget(),
          ),
        ],
      ),
    );
  }
}

class _BarcodeWidget extends StatelessWidget {
  const _BarcodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dm = Barcode.code39();
    final svg = dm.toSvg(
      '0000 0000 0000 0000',
      width: 400,
      height: 200,
      drawText: false,
    );
    return SvgPicture.string(svg);
  }
}

class _QrCode extends StatelessWidget {
  const _QrCode({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dm = Barcode.dataMatrix();
    final svg = dm.toSvg(
      '0000 0000 0000 0000',
      width: 200,
      height: 200,
      drawText: false,
    );
    return Center(
      child: SvgPicture.string(svg),
    );
  }
}

class _PaymentMethod extends StatelessWidget {
  const _PaymentMethod({
    required this.paymentTitle,
    required this.buttonTitle,
    required this.buttonCallback,
    required this.display,
  });

  final String paymentTitle;
  final String buttonTitle;
  final VoidCallback buttonCallback;
  final Widget display;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            paymentTitle,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrange,
                ),
          ),
          const Text("Copie o código abaixo para realizar o pagamento"),
          const SizedBox(
            height: 16,
          ),
          display,
          const SizedBox(
            height: 16,
          ),
          MaterialButton(
            color: Colors.deepOrangeAccent,
            onPressed: buttonCallback,
            child: Text(
              buttonTitle,
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: Colors.white,
                  ),
            ),
          )
        ],
      ),
    );
  }
}

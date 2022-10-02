import 'package:flutter/material.dart';

class PaymentClipboardSnack {
  static SnackBar show(String codeType) => SnackBar(
        content: Text("Seu $codeType foi copiado com sucesso!"),
      );
}

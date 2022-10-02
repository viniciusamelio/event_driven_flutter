import 'package:event_driven_flutter/app.dart';
import 'package:event_driven_flutter/events.dart';
import 'package:event_driven_flutter/snack.dart';

class PaymentMethodCliboardEventHandler implements EventHandler {
  @override
  Future<void> call(Event event) async {
    final state = Keys.scaffoldMessengerKey.currentState;
    if (state != null) {
      if (event is PaymentMethodClipboardEvent) {
        if (event is PixClipboardEvent) {
          state.showSnackBar(
            PaymentClipboardSnack.show("código ${event.data["code"]} pix"),
          );
          return;
        }
        state.showSnackBar(
          PaymentClipboardSnack.show("código ${event.data["code"]} de barras"),
        );
      }
    }
  }
}

abstract class PaymentMethodClipboardEvent implements Event {
  PaymentMethodClipboardEvent({required this.code});

  final String code;
}

class PixClipboardEvent implements PaymentMethodClipboardEvent {
  PixClipboardEvent({required this.code});

  @override
  Map<String, dynamic> get data => {
        "code": code,
      };

  @override
  final String code;
}

class BilletClipboardEvent implements PaymentMethodClipboardEvent {
  BilletClipboardEvent({required this.code});

  @override
  Map<String, dynamic> get data => {
        "code": code,
      };

  @override
  final String code;
}

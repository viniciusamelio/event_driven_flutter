import 'package:event_driven_flutter/eventbus.dart';
import 'package:event_driven_flutter/events.dart';
import 'package:event_driven_flutter/payment_method_clipboard_event.dart';
import 'package:get_it/get_it.dart';

abstract class DI {
  static Future<void> init() async {
    GetIt.I.registerSingleton<EventBus>(StreamEventBus()
      ..addHandler(
        PaymentMethodCliboardEventHandler(),
      ));
  }

  static T get<T extends Object>([String? name]) =>
      GetIt.I.get<T>(instanceName: name);
}

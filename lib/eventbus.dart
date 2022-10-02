import 'dart:async';

import 'package:event_driven_flutter/events.dart';

class StreamEventBus implements EventBus {
  final _stream = StreamController<Event>.broadcast();

  @override
  Future<void> addEvent(Event event) async {
    _stream.add(event);
  }

  @override
  Future<void> addHandler(EventHandler handler) async {
    _stream.stream.listen((event) {
      handler(event);
    });
  }
}

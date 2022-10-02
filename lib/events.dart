abstract class Event {
  Event(this.data);
  final Map<String, dynamic> data;
}

abstract class EventHandler {
  Future<void> call(Event event);
}

abstract class EventBus {
  Future<void> addHandler(EventHandler handler);
  Future<void> addEvent(Event event);
}

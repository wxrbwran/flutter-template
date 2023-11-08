import 'package:event_bus/event_bus.dart';

class GlobalEvent {
  factory GlobalEvent() => _getInstance();
  static GlobalEvent? _instance;

  static GlobalEvent _getInstance() {
    _instance ??= GlobalEvent._internal();
    return _instance!;
  }

  late EventBus eventBus;

  GlobalEvent._internal() {
    eventBus = EventBus();
  }
}

import 'websocket_event.dart';

class WebSocketPing extends WebSocketEvent {

  @override
  WebSocketPing();

  @override
  WebSocketPing.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketPing.fromJson(String data): super.fromJson(data);

  @override
  Map<String, Object> asMap() => {};

  @override
  void readFromMap(Map<String, Object> data) {}

}
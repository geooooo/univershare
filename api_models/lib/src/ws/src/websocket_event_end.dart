import 'websocket_event.dart';

class WebSocketEventEnd extends WebSocketEvent {

  @override
  String name = 'event_end';

  @override
  WebSocketEventEnd();

  @override
  WebSocketEventEnd.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketEventEnd.fromJson(String data): super.fromJson(data);

}
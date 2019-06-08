import 'websocket_event.dart';

class WebSocketPong extends WebSocketEvent {

  @override
  WebSocketPong();

  @override
  WebSocketPong.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketPong.fromJson(String data): super.fromJson(data);

}
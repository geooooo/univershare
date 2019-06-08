import 'websocket_event.dart';

class WebSocketRetry extends WebSocketEvent {

  @override
  String name = 'retry';

  @override
  WebSocketRetry();

  @override
  WebSocketRetry.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketRetry.fromJson(String data): super.fromJson(data);

}
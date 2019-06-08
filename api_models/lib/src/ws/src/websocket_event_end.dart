import 'websocket_event.dart';

class WebSocketEventEndData extends WebSocketEvent {

  @override
  String name = 'event_end';

  @override
  WebSocketEventEndData();

  @override
  WebSocketEventEndData.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketEventEndData.fromJson(String data): super.fromJson(data);

}
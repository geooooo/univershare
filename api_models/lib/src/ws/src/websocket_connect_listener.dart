import 'websocket_event.dart';

class WebSocketConnectListener extends WebSocketEvent {

  @override
  String name = 'connect_listener';
  String eventId;
  int userId;

  @override
  WebSocketConnectListener({
    this.eventId,
    this.userId,
  });

  @override
  WebSocketConnectListener.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketConnectListener.fromJson(String data): super.fromJson(data);

  @override
  Map<String, Object> asMap() => super.asMap()..addAll({
    'event_id': eventId,
    'user_id': userId,
  });

  @override
  void readFromMap(Map<String, Object> data) {
    super.readFromMap(data);
    eventId = data['event_id'];
    userId = data['user_id'];
  }

}
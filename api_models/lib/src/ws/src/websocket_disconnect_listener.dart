import 'websocket_event.dart';

class WebSocketDisconnectListener extends WebSocketEvent {

  @override
  String name = 'disconnect_listener';
  String eventId;
  int userId;

  @override
  WebSocketDisconnectListener({
    this.eventId,
    this.userId,
  });

  @override
  WebSocketDisconnectListener.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketDisconnectListener.fromJson(String data): super.fromJson(data);

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
import 'websocket_event.dart';

class WebSocketConnect extends WebSocketEvent {

  @override
  String name = 'connect';
  String eventId;
  int userId;

  @override
  WebSocketConnect({
    this.eventId,
    this.userId,
  });

  @override
  WebSocketConnect.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketConnect.fromJson(String data): super.fromJson(data);

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
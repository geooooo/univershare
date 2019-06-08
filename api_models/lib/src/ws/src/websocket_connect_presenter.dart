import 'websocket_event.dart';

class WebSocketConnectPresenter extends WebSocketEvent {

  @override
  String name = 'connect_presenter';
  String eventId;
  int userId;

  @override
  WebSocketConnectPresenter({
    this.eventId,
    this.userId,
  });

  @override
  WebSocketConnectPresenter.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketConnectPresenter.fromJson(String data): super.fromJson(data);

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
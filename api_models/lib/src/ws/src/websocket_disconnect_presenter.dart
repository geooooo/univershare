import 'websocket_event.dart';

class WebSocketDisconnectPresenter extends WebSocketEvent {

  @override
  String name = 'disconnect_presenter';
  String eventId;

  @override
  WebSocketDisconnectPresenter({
    this.eventId,
  });

  @override
  WebSocketDisconnectPresenter.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketDisconnectPresenter.fromJson(String data): super.fromJson(data);

  @override
  Map<String, Object> asMap() => super.asMap()..addAll({
    'event_id': eventId,
  });

  @override
  void readFromMap(Map<String, Object> data) {
    super.readFromMap(data);
    eventId = data['event_id'];
  }

}
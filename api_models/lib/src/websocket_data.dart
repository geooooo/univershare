import 'request.dart';

abstract class WebSocketData extends Request {

  String eventId;
  int userId;

  Map<String, Object> asMap() => {
    'event_id': eventId,
    'user_id': userId,
  };

  void readFromMap(Map<String, Object> inputMap) {
    eventId = inputMap['event_id'];
    userId = inputMap['user_id'];
  }

}
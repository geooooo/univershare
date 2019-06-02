import 'response.dart';
import 'request.dart';

class JoinEventRequest extends Request {

  String eventId;
  String userName;

  @override
  Map<String, Object> asMap() => {
    'event_id': eventId,
    'user_name': userName,
  };

  @override
  void readFromMap(Map<String, Object> inputMap) {
    eventId = inputMap['event_id'];
    userName = inputMap['user_name'];
  }

}

// status:
//    0 - ok
class JoinEventResponse extends Response {

  int userId;

  @override
  Map<String, Object> asMap() => super.asMap()..addAll({
    'user_id': userId,
  });

  @override
  void readFromMap(Map<String, Object> inputMap) {
    super.readFromMap(inputMap);
    userId = inputMap['user_id'];
  }

}
import 'response.dart';
import 'request.dart';

class GetNewEventIdRequest extends Request {

  @override
  Map<String, Object> asMap() => {};

  @override
  void readFromMap(Map<String, Object> inputMap) {}

}

// status:
//    0 - ok
class GetNewEventIdResponse extends Response {

  String eventId;

  @override
  Map<String, Object> asMap() => super.asMap()..addAll({
    'event_id': eventId,
  });

  @override
  void readFromMap(Map<String, Object> inputMap) {
    super.readFromMap(inputMap);
    eventId = inputMap['event_id'];
  }

}

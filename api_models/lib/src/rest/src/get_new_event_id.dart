import 'response.dart';
import 'request.dart';

class GetNewEventIdRequest extends Request {

  @override
  GetNewEventIdRequest();

  @override
  Map<String, Object> asMap() => {};

  @override
  void readFromMap(Map<String, Object> data) {}

}

// status:
//    0 - ok
class GetNewEventIdResponse extends Response {

  String eventId;

  GetNewEventIdResponse({
    this.eventId,
  });

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

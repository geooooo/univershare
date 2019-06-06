import 'response.dart';
import 'request.dart';

class ExistsEventRequest extends Request {

  String eventId;

  @override
  ExistsEventRequest({
    this.eventId,
  });

  @override
  Map<String, Object> asMap() => {
    'event_id': eventId,
  };

  @override
  void readFromMap(Map<String, Object> data) {
    eventId = data['event_id'];
  }

}

// status:
//    0 - существует
//    1 - не существует
class ExistsEventResponse extends Response {}

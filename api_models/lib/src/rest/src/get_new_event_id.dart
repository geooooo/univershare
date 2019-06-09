import 'response.dart';
import 'request.dart';

class GetNewEventIdRequest extends Request {

  @override
  GetNewEventIdRequest();

  @override
  GetNewEventIdRequest.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  GetNewEventIdRequest.fromJson(String data): super.fromJson(data);

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
    int status,
    this.eventId,
  }): super(status: status);

  @override
  GetNewEventIdResponse.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  GetNewEventIdResponse.fromJson(String data): super.fromJson(data);

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

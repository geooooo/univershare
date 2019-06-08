import 'response.dart';
import 'request.dart';

class JoinEventRequest extends Request {

  String eventId;
  String userName;

  @override
  JoinEventRequest({
    this.eventId,
    this.userName,
  });

  @override
  JoinEventRequest.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  Map<String, Object> asMap() => {
    'event_id': eventId,
    'user_name': userName,
  };

  @override
  void readFromMap(Map<String, Object> data) {
    eventId = data['event_id'];
    userName = data['user_name'];
  }

}

// status:
//    0 - ok
class JoinEventResponse extends Response {

  int userId;
  String eventName;
  String presentationUrl;

  JoinEventResponse({
    int status,
    this.userId,
    this.eventName,
    this.presentationUrl,
  }): super(status: status);

  @override
  JoinEventResponse.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  Map<String, Object> asMap() => super.asMap()..addAll({
    'user_id': userId,
    'event_name': eventName,
    'presentation_url': presentationUrl,
  });

  @override
  void readFromMap(Map<String, Object> data) {
    super.readFromMap(data);
    userId = data['user_id'];
    eventName = data['event_name'];
    presentationUrl = data['presentation_url'];
  }

}
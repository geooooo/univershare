import 'response.dart';
import 'request.dart';

class CreateEventRequest extends Request {

  String eventId;
  String eventName;
  String userName;
  String presentationFile;

  @override
  CreateEventRequest({
    this.eventId,
    this.eventName,
    this.userName,
    this.presentationFile,
  });

  @override
  CreateEventRequest.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  CreateEventRequest.fromJson(String data): super.fromJson(data);

  @override
  Map<String, Object> asMap() => {
    'event_id': eventId,
    'event_name': eventName,
    'user_name': userName,
    'presentation_file': presentationFile,
  };

  @override
  void readFromMap(Map<String, Object> data) {
    eventId = data['event_id'];
    eventName = data['event_name'];
    userName = data['user_name'];
    presentationFile = data['presentation_file'];
  }

}

// status:
//    0 - ok
class CreateEventResponse extends Response {

  int userId;

  @override
  CreateEventResponse({
    int status,
    this.userId,
  }): super(status: status);

  @override
  CreateEventResponse.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  CreateEventResponse.fromJson(String data): super.fromJson(data);

  @override
  Map<String, Object> asMap() => super.asMap()..addAll({
    'user_id': userId,
  });

  @override
  void readFromMap(Map<String, Object> data) {
    super.readFromMap(data);
    userId = data['user_id'];
  }

}

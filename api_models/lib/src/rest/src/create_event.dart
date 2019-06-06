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
class CreateEventResponse extends Response {}

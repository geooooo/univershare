import 'response.dart';
import 'request.dart';

class CreateEventRequest extends Request {

  String eventId;
  String eventName;
  String userName;
  String presentationFile;

  @override
  Map<String, Object> asMap() => {
    'event_id': eventId,
    'event_name': eventName,
    'user_name': userName,
    'presentation_file': presentationFile,
  };

  @override
  void readFromMap(Map<String, Object> inputMap) {
    eventId = inputMap['event_id'];
    eventName = inputMap['event_name'];
    userName = inputMap['user_name'];
    presentationFile = inputMap['presentation_file'];
  }

}

// status:
//    0 - ok
class CreateEventResponse extends Response {}

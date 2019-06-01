
import 'package:aqueduct/aqueduct.dart' hide Response;

import 'package:api_models/src/response.dart';

class CreateEventRequest extends Serializable {

  int eventId;
  String eventName;
  String userName;
  String presentationFile;

  @override
  Map<String, dynamic> asMap() => {
    'event_id': eventId,
    'event_name': eventName,
    'user_name': userName,
    'presentation_file': presentationFile,
  };

  @override
  void readFromMap(Map<String, dynamic> inputMap) {
    eventId = inputMap['event_id'];
    eventName = inputMap['event_name'];
    userName = inputMap['user_name'];
    presentationFile = inputMap['presentation_file'];
  }

}

// status:
//    0 - ok
class CreateEventResponse extends Response {}

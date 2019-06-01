import 'package:aqueduct/aqueduct.dart' hide Response;

import 'response.dart';

class ListenerEventExitRequest extends Serializable {

  String eventId;
  int userId;

  @override
  Map<String, Object> asMap() => {
    'event_id': eventId,
    'user_id': userId,
  };

  @override
  void readFromMap(Map<String, Object> inputMap) {
    eventId = inputMap['event_id'];
    userId = inputMap['user_id'];
  }

}

// status:
//    0 - ok
class ListenerEventExitResponse extends Response {}

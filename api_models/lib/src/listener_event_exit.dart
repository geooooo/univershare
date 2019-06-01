
import 'package:aqueduct/aqueduct.dart' hide Response;

import 'package:api_models/src/response.dart';

class ListenerEventExitRequest extends Serializable {

  String eventId;
  String userId;

  @override
  Map<String, dynamic> asMap() => {
    'event_id': eventId,
    'user_id': userId,
  };

  @override
  void readFromMap(Map<String, dynamic> inputMap) {
    eventId = inputMap['event_id'];
    userId = inputMap['user_id'];
  }

}

// status:
//    0 - ok
class ListenerEventExitResponse extends Response {}

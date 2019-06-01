
import 'package:aqueduct/aqueduct.dart' hide Response;

import 'package:api_models/src/response.dart';

class JoinEventRequest extends Serializable {

  String eventId;
  String userName;

  @override
  Map<String, dynamic> asMap() => {
    'event_id': eventId,
    'user_name': userName,
  };

  @override
  void readFromMap(Map<String, dynamic> inputMap) {
    eventId = inputMap['event_id'];
    userName = inputMap['user_name'];
  }

}

// status:
//    0 - ok
class JoinEventResponse extends Response {

  int userId;

  @override
  Map<String, dynamic> asMap() => super.asMap()..addAll({
    'user_id': userId,
  });

  @override
  void readFromMap(Map<String, dynamic> inputMap) {
    super.readFromMap(inputMap);
    userId = inputMap['user_id'];
  }

}
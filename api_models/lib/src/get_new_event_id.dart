
import 'package:aqueduct/aqueduct.dart' hide Response;

import 'package:api_models/src/response.dart';

class GetNewEventIdRequest extends Serializable {

  @override
  Map<String, dynamic> asMap() => {};

  @override
  void readFromMap(Map<String, dynamic> inputMap) {}

}

// status:
//    0 - ok
class GetNewEventIdResponse extends Response {

  String eventId;

  @override
  Map<String, dynamic> asMap() => super.asMap()..addAll({
    'event_id': eventId,
  });

  @override
  void readFromMap(Map<String, dynamic> inputMap) {
    super.readFromMap(inputMap);
    eventId = inputMap['event_id'];
  }

}

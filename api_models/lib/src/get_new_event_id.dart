import 'package:aqueduct/aqueduct.dart' hide Response;

import 'response.dart';

class GetNewEventIdRequest extends Serializable {

  @override
  Map<String, Object> asMap() => {};

  @override
  void readFromMap(Map<String, Object> inputMap) {}

}

// status:
//    0 - ok
class GetNewEventIdResponse extends Response {

  String eventId;

  @override
  Map<String, Object> asMap() => super.asMap()..addAll({
    'event_id': eventId,
  });

  @override
  void readFromMap(Map<String, Object> inputMap) {
    super.readFromMap(inputMap);
    eventId = inputMap['event_id'];
  }

}

import 'package:aqueduct/aqueduct.dart' hide Response;

import 'response.dart';

class ExistsEventRequest extends Serializable {

  String eventId;

  @override
  Map<String, Object> asMap() => {
      'event_id': eventId,
  };

  @override
  void readFromMap(Map<String, Object> inputMap) {
    eventId = inputMap['event_id'];
  }

}

// status:
//    0 - существует
//    1 - не существует
class ExistsEventResponse extends Response {}

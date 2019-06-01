import 'package:aqueduct/aqueduct.dart' hide Response;

import 'response.dart';

class PresenterEventExitRequest extends Serializable {

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
//    0 - ok
class PresenterEventExitResponse extends Response {}

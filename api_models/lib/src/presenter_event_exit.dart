
import 'package:aqueduct/aqueduct.dart' hide Response;

import 'package:api_models/src/response.dart';

class PresenterEventExitRequest extends Serializable {

  String eventId;

  @override
  Map<String, dynamic> asMap() => {
      'event_id': eventId,
  };

  @override
  void readFromMap(Map<String, dynamic> inputMap) {
    eventId = inputMap['event_id'];
  }

}

// status:
//    0 - ok
class PresenterEventExitResponse extends Response {}

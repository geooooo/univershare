
import 'package:aqueduct/aqueduct.dart' hide Response;

import 'package:api_models/src/response.dart';

class ExistsEventRequest extends Serializable {

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
//    0 - существует
//    1 - не существует
class ExistsEventResponse extends Response {}


import 'package:aqueduct/aqueduct.dart' hide Response;

import 'package:api_models/src/response.dart';

class GetEventInfoRequest extends Serializable {

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
class GetEventInfoResponse extends Response {
  String eventName = '';
  String presentationUrl = '';

  @override
  Map<String, dynamic> asMap() => super.asMap()..addAll({
    'event_name': eventName,
    'presentation_url': presentationUrl,
  });

  @override
  void readFromMap(Map<String, dynamic> inputMap) {
    super.readFromMap(inputMap);
    eventName = inputMap['event_name'];
    presentationUrl = inputMap['presentation_url'];
  }

}
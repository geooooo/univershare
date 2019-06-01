import 'package:aqueduct/aqueduct.dart' hide Response;

import 'response.dart';

class GetEventInfoRequest extends Serializable {

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
class GetEventInfoResponse extends Response {
  String eventName = '';
  String presentationUrl = '';

  @override
  Map<String, Object> asMap() => super.asMap()..addAll({
    'event_name': eventName,
    'presentation_url': presentationUrl,
  });

  @override
  void readFromMap(Map<String, Object> inputMap) {
    super.readFromMap(inputMap);
    eventName = inputMap['event_name'];
    presentationUrl = inputMap['presentation_url'];
  }

}
import 'package:aqueduct/aqueduct.dart' show Serializable;

abstract class WebSocketData extends Serializable {

  String eventId;
  int userId;

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
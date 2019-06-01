import 'package:aqueduct/aqueduct.dart' hide Response;

import 'response.dart';
import 'message.dart';

class GetEventMessagesRequest extends Serializable {

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
class GetEventMessagesResponse extends Response {

  List<Message> messages;

  @override
  Map<String, Object> asMap() => super.asMap()..addAll({
    'messages': messages.map((message) => message.asMap()).toList(),
  });

  @override
  void readFromMap(Map<String, Object> inputMap) {
    final Iterable<Map<String, Object>> messagesMap = inputMap['messages'];
    messages = messagesMap.map((message) => Message().readFromMap(message));
  }

}

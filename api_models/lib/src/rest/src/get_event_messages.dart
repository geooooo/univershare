import 'response.dart';
import 'request.dart';
import 'message.dart';

class GetEventMessagesRequest extends Request {

  String eventId;

  @override
  GetEventMessagesRequest({
    this.eventId,
  });

  @override
  Map<String, Object> asMap() => {
    'event_id': eventId,
  };

  @override
  void readFromMap(Map<String, Object> data) {
    eventId = data['event_id'];
  }

}

// status:
//    0 - ok
class GetEventMessagesResponse extends Response {

  List<Message> messages;

  @override
  GetEventMessagesResponse({
    this.messages,
  });

  @override
  Map<String, Object> asMap() => super.asMap()..addAll({
    'messages': messages.map((message) => message.asMap()).toList(),
  });

  @override
  void readFromMap(Map<String, Object> data) {
    super.readFromMap(data);
    final Iterable<Object> messagesMap = data['messages'];
    messages = messagesMap.map((message) => Message()..readFromMap(message)).toList();
  }

}

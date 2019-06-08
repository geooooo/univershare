import 'websocket_event.dart';

class WebSocketNewMessage extends WebSocketEvent {

  @override
  String name = 'new_message';
  String text;
  String userName;
  bool isQuestion;
  String eventId;
  int userId;

  @override
  WebSocketNewMessage({
    this.text,
    this.userName,
    this.isQuestion,
    this.eventId,
    this.userId,
  });

  @override
  WebSocketNewMessage.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketNewMessage.fromJson(String data): super.fromJson(data);

  @override
  Map<String, Object> asMap() => super.asMap()..addAll({
    'text': text,
    'user_name': userName,
    'is_question': isQuestion,
    'event_id': eventId,
    'user_id': userId,
  });

  @override
  void readFromMap(Map<String, Object> data) {
    super.readFromMap(data);
    text = data['text'];
    userName = data['user_name'];
    isQuestion = data['is_question'];
    eventId = data['event_id'];
    userId = data['user_id'];
  }

}
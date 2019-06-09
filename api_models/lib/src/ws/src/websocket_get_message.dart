import 'websocket_event.dart';

class WebSocketGetMessage extends WebSocketEvent {

  @override
  String name = 'get_message';
  String text;
  int userId;
  String userName;
  bool isQuestion;

  @override
  WebSocketGetMessage({
    this.userId,
    this.text,
    this.userName,
    this.isQuestion,
  });

  @override
  WebSocketGetMessage.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketGetMessage.fromJson(String data): super.fromJson(data);

  @override
  Map<String, Object> asMap() => super.asMap()..addAll({
    'user_id': userId,
    'text': text,
    'user_name': userName,
    'is_question': isQuestion,
  });

  @override
  void readFromMap(Map<String, Object> data) {
    super.readFromMap(data);
    userId = data['user_id'];
    text = data['text'];
    userName = data['user_name'];
    isQuestion = data['is_question'];
  }

}
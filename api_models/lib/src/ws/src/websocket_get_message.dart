import 'websocket_event.dart';

class WebSocketGetMessage extends WebSocketEvent {

  @override
  String name = 'get_message';
  String text;
  String userName;
  bool isQuestion;

  @override
  WebSocketGetMessage({
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
    'text': text,
    'user_name': userName,
    'is_question': isQuestion,
  });

  @override
  void readFromMap(Map<String, Object> data) {
    super.readFromMap(data);
    text = data['text'];
    userName = data['user_name'];
    isQuestion = data['is_question'];
  }

}
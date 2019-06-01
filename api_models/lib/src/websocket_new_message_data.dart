import 'websocket_data.dart';

class WebSocketNewMessageData extends WebSocketData {

  String text;
  String userName;
  bool isQuestion;

  @override
  Map<String, dynamic> asMap() => super.asMap()..addAll({
    'text': text,
    'user_name': userName,
    'is_question': isQuestion,
  });

  @override
  void readFromMap(Map<String, dynamic> inputMap) {
    super.readFromMap(inputMap);
    text = inputMap['text'];
    userName = inputMap['user_name'];
    isQuestion = inputMap['is_question'];
  }

}
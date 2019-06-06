import 'package:api_models/src/rest/src/request.dart';

class Message extends Request {

  String text;
  String userName;
  bool isQuestion;

  @override
  Map<String, Object> asMap() => {
    'text': text,
    'user_name': userName,
    'is_question': isQuestion,
  };

  @override
  void readFromMap(Map<String, Object> inputMap) {
    text = inputMap['text'];
    userName = inputMap['user_name'];
    isQuestion = inputMap['is_question'];
  }

}
import 'package:aqueduct/aqueduct.dart' show Serializable;

class Message extends Serializable {

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
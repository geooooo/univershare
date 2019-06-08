import '../../serializable.dart';

class Message extends Serializable {

  String text;
  String userName;
  bool isQuestion;

  @override
  Message({
    this.text,
    this.userName,
    this.isQuestion
  });

  @override
  Message.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  Map<String, Object> asMap() => {
    'text': text,
    'user_name': userName,
    'is_question': isQuestion,
  };

  @override
  void readFromMap(Map<String, Object> data) {
    text = data['text'];
    userName = data['user_name'];
    isQuestion = data['is_question'];
  }

}
import '../../serializable.dart';

class Message extends Serializable {

  String text;
  String userName;
  bool isQuestion;
  int userId;

  @override
  Message({
    this.text,
    this.userName,
    this.isQuestion,
    this.userId,
  });

  @override
  Message.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  Map<String, Object> asMap() => {
    'text': text,
    'user_name': userName,
    'is_question': isQuestion,
    'user_id': userId,
  };

  @override
  void readFromMap(Map<String, Object> data) {
    text = data['text'];
    userName = data['user_name'];
    isQuestion = data['is_question'];
    userId = data['user_id'];
  }

}
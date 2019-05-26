class AppState {

  String userName = 'vasia'; //TODO: temp
  String eventId = '111-111-111'; //TODO: temp
  String eventName = 'eventName'; //TODO: temp
  String presentationUrl = 'http://www.africau.edu/images/default/sample.pdf'; //TODO: temp
  List<Message> messages = [
    Message(
      userName: 'vasia',
      text: 'hello !',
      isQuestion: true,
    ),
    Message(
      userName: 'john',
      text: 'hello, vasia !\nHello All !!!',
      isQuestion: true,
    ),
    Message(
      userName: 'jora',
      text: ':)',
      isQuestion: true,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: true,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: true,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: true,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: true,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: true,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: true,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: true,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: true,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: true,
    ),
    Message(
      userName: 'petia',
      text: 'qwerty',
      isQuestion: true,
    ),
  ]; //TODO: temp

  StartPageState startPageState = StartPageState.initial();

  AppState._();

  AppState.initial();

}

class StartPageState {

  bool isJoinButtonDisabled = false;  //TODO: temp

  StartPageState._();

  StartPageState.initial();

}

class Message {

  String userName;
  String text;
  bool isQuestion;

  Message({
    this.userName,
    this.text,
    this.isQuestion,
  });

}
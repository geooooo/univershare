class AppState {

  String userName = 'vasia'; //TODO: temp
  String eventId = '111-111-111'; //TODO: temp
  String eventName = 'eventName'; //TODO: temp
  List<Message> messages = [
    Message(
      userName: 'vasia',
      text: 'hello !',
      isQuestion: false,
    ),
    Message(
      userName: 'john',
      text: 'hello, vasia !\nHello All !!!',
      isQuestion: false,
    ),
    Message(
      userName: 'jora',
      text: ':)',
      isQuestion: false,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: false,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: false,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: false,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: false,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: false,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: false,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: false,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: false,
    ),
    Message(
      userName: 'ivan',
      text: '1234567\n1234\n345345\n',
      isQuestion: false,
    ),
    Message(
      userName: 'petia',
      text: 'qwerty',
      isQuestion: false,
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

  final String userName;
  final String text;
  final bool isQuestion;

  Message({
    this.userName,
    this.text,
    this.isQuestion,
  });

}
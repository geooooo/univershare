class AppState {

  String userName = '';
  String eventId = '';
  String eventName = '';
  String presentationUrl = '';
  List<Message> messages = [];

  StartPageState startPageState = StartPageState.initial();

  AppState._();

  AppState.initial();

}

class StartPageState {

  bool isJoinButtonDisabled = true;
  bool isShowDialogJoin = false;

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
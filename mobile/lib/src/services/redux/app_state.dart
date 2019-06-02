class AppState {

  int userId = 0;
  String userName = '';
  String eventId = '';
  String eventName = '';
  String presentationUrl = '';
  List<Message> messages = [];
  bool isLoadingShow = false;

  StartPageState startPageState = StartPageState.initial();

  AppState._();

  AppState.initial();

}

class StartPageState {

  bool isJoinButtonDisabled = true;

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
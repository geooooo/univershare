class AppState {

  String userName = '';
  String eventId = '';
//  String eventId = '111-222-333';
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
//  bool isJoinButtonDisabled = false;

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
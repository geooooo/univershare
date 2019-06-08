import 'dart:io' as io;

class AppState {

  int userId = 0;
  String userName = '';
  String eventId = '123-456-789';
  String eventName = '';
  String presentationUrl = '';
  List<Message> messages = [];
  bool isLoadingShow = false;
  io.WebSocket socket;

  StartPageState startPageState = StartPageState.initial();

  AppState._();

  AppState.initial();

}

class StartPageState {

  bool isJoinButtonDisabled = false;

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
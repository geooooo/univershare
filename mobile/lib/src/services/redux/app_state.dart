import 'package:web_socket_channel/web_socket_channel.dart';

class AppState {

  int userId = 0;
  String userName = 'a';
  String eventId = '123-456-322';
  String eventName = '';
  String presentationUrl = '';
  List<Message> messages = [];
  bool isLoadingShow = false;
  WebSocketChannel socket;

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
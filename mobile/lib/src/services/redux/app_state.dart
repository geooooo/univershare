import 'dart:io' as io;

import '../../models/message.dart';

class AppState {

  int userId = 0;
  String userName = 'vasia';
  String eventId = '';
  String eventName = '';
  String presentationUrl = '';
  List<Message> messages = [
    Message(
      userName: 'vasia',
      text: 'message message message',
      isQuestion: true,
    ),
    Message(
      userName: 'vasia1',
      text: 'message message message 1',
      isQuestion: true,
    ),
    Message(
      userName: 'vasia',
      text: 'message message message 2',
      isQuestion: true,
    ),
    Message(
      userName: 'vasia',
      text: 'message message message',
      isQuestion: true,
    ),
    Message(
      userName: 'vasia1',
      text: 'message message message 1',
      isQuestion: true,
    ),
    Message(
      userName: 'vasia',
      text: 'message message message 2',
      isQuestion: true,
    ),
    Message(
      userName: 'vasia',
      text: 'message message message',
      isQuestion: true,
    ),
    Message(
      userName: 'vasia1',
      text: 'message message message 1',
      isQuestion: true,
    ),
    Message(
      userName: 'vasia',
      text: 'message message message 2',
      isQuestion: true,
    ),
  ];
  bool isLoadingVisible = false;
  io.WebSocket socket;

  StartPageState startPageState = StartPageState.initial();

  AppState._();

  AppState.initial();

}

class StartPageState {

  bool isJoinButtonDisabled = true;

  StartPageState._();

  StartPageState.initial();

}
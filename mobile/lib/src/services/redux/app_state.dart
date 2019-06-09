import 'dart:io' as io;

import '../../models/message.dart';

class AppState {

  int userId = 0;
  String userName = '';
  String eventId = '';
  String eventName = '';
  String presentationUrl = '';
  List<Message> messages = [];
  bool isLoadingVisible = false;
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
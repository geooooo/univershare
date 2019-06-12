 import 'dart:io' as io;

import 'package:flutter/material.dart';

import '../../models/message.dart';
import '../../models/user_type.dart';

class AppState {

  int userId = 0;
  String userName = '';
  String eventId = '';
  String eventName = '';
  String presentationUrl = '';
  List<Message> messages = [];
  bool isLoadingVisible = false;
  bool isEventActive = false;
  io.WebSocket socket;
  BuildContext context;
  UserType userType;

  StartPageState startPageState = StartPageState.initial();

  AppState._();

  AppState.initial();

}

class StartPageState {

  bool isJoinButtonDisabled = false;

  StartPageState._();

  StartPageState.initial();

}
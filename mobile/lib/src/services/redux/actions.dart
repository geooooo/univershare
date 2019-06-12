import 'dart:io' as io;

import 'package:flutter/material.dart';

import '../../models/message.dart';

class SetEventId {

  final String eventId;
  final bool isValid;

  SetEventId(this.eventId, this.isValid);

}

class ExitEvent {

  ExitEvent();

}

class SetUserId {

  final int userId;

  SetUserId(this.userId);

}

class SetUserName {

  final String userName;

  SetUserName(this.userName);

}

class SetContext {

  final BuildContext context;

  SetContext(this.context);

}

class SendMessage {

  Message message;

  SendMessage(this.message);

}

class CreateEvent {

  final String eventName;
  final String userName;

  CreateEvent(this.eventName, this.userName);

}

class CheckQuestion {

  final Message message;

  CheckQuestion(this.message);

}

class Loading {

  final bool isVisible;

  Loading(this.isVisible);

}

class SetEventInfo {

  final String eventName;
  final String presentationUrl;

  SetEventInfo(this.eventName, this.presentationUrl);

}

class SetSocket {

  final io.WebSocket socket;

  SetSocket(this.socket);

}

class SaveMessages {

  final List<Message> messages;

  SaveMessages(this.messages);

}
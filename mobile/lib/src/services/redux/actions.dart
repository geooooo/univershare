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
  final int userId;

  CreateEvent(this.eventName, this.userName, this.userId);

}

class CheckQuestion {

  final Message message;

  CheckQuestion(this.message);

}

class Loading {

  final bool isVisible;

  Loading(this.isVisible);

}

class JoinEvent {

  final String eventName;
  final String presentationUrl;
  final String userName;
  final int userId;

  JoinEvent(this.eventName, this.presentationUrl, this.userName, this.userId);

}

class SetSocket {

  final io.WebSocket socket;

  SetSocket(this.socket);

}

class SaveMessages {

  final List<Message> messages;

  SaveMessages(this.messages);

}

class EventEnd {

  EventEnd();

}
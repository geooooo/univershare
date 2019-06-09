import 'dart:io' as io;

import 'package:api_models/api_models.dart' as api_models;

import '../../models/message.dart';
import 'app_state.dart';

class SetEventId {

  final String eventId;
  final bool isValid;

  SetEventId(this.eventId, this.isValid);

}

class SetUserName {

  final String userName;

  SetUserName(this.userName);

}

class SendMessage {

  final String message;
  final String userName;
  final bool isQuestion;

  SendMessage(this.message, this.userName, this.isQuestion);

}

class CreateEvent {

  final String eventName;
  final String userName;

  CreateEvent(this.eventName, this.userName);

}

class DeleteMessageFromQuestions {

  final Message message;

  DeleteMessageFromQuestions(this.message);

}

class Loading {

  final bool isVisible;

  Loading(this.isVisible);

}

class SetEventInfo {

  final String eventName;
  final String presentationUrl;
  final int userId;

  SetEventInfo(this.eventName, this.presentationUrl, this.userId);

}

class SocketConnect {

  final io.WebSocket socket;

  SocketConnect(this.socket);

}

class SaveMessages {

  final List<api_models.Message> messages;

  SaveMessages(this.messages);

}

class SocketClose {

  SocketClose();

}
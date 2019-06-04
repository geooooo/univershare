import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:api_models/api_models.dart' as api_models;

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

  final bool isShow;

  Loading(this.isShow);

}

class SetEventInfo {

  final String eventName;
  final String presentationUrl;
  final int userId;

  SetEventInfo(this.eventName, this.presentationUrl, this.userId);

}

class SocketConnect {

  final WebSocketChannel socket;

  SocketConnect(this.socket);

}

class SaveMessages {

  final List<api_models.Message> messages;

  SaveMessages(this.messages);

}

class SocketClose {

  SocketClose();

}
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

class ExistsEvent {

  final String eventId;

  ExistsEvent(this.eventId);

}

class ExistsEventResult {

  final bool status;

  ExistsEventResult(this.status);

}

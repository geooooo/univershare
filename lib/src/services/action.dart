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
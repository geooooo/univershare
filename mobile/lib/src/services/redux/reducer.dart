import 'package:redux/redux.dart';

import 'app_state.dart';
import 'action.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, SetEventId>(_onSetEventId),
  TypedReducer<AppState, SetUserName>(_onSetUserName),
  TypedReducer<AppState, SendMessage>(_onSendMessage),
  TypedReducer<AppState, CreateEvent>(_onCreateEvent),
  TypedReducer<AppState, DeleteMessageFromQuestions>(_onDeleteMessageFromQuestions),
  TypedReducer<AppState, ExistsEventResult>(_onExistsEventResult),
]);

AppState _onSetEventId(AppState state, SetEventId action) {
  print(
    'Action: SetEventId {\n'
    '\teventId: ${action.eventId}\n'
    '\tisValid: ${action.isValid}\n'
    '}\n'
  );
  return state
    ..eventId = action.eventId
    ..startPageState.isJoinButtonDisabled = !action.isValid;
}

AppState _onSetUserName(AppState state, SetUserName action) {
  print(
    'Action: SetUserName {\n'
      '\tuserName: ${action.userName}\n'
    '}\n'
  );
  return state
    ..userName = action.userName;
}

AppState _onSendMessage(AppState state, SendMessage action) {
  print(
    'Action: SendMessage {\n'
      '\tuserName: ${action.userName}\n'
      '\tmessage: ${action.message}\n'
      '\tisQuestion: ${action.isQuestion}\n'
    '}\n'
  );
  return state..messages.add(Message(
    userName: action.userName,
    text: action.message,
    isQuestion: action.isQuestion,
  ));
}

AppState _onCreateEvent(AppState state, CreateEvent action) {
  print(
    'Action: CreateEvent {\n'
      '\tuserName: ${action.userName}\n'
      '\teventName: ${action.eventName}\n'
    '}\n'
  );
  return state
    ..userName = action.userName
    ..eventName = action.eventName;
}

AppState _onDeleteMessageFromQuestions(AppState state, DeleteMessageFromQuestions action) {
  print(
    'Action: DeleteMessageFromQuestions {\n'
      '\tmessage.hashCode: ${action.message.hashCode}\n'
    '}\n'
  );
  return state..messages.firstWhere((message) => message == action.message)
                        .isQuestion = false;
}

AppState _onExistsEventResult(AppState state, ExistsEventResult action) {
  print(
    'Action: ExistsEventResult {\n'
      '\status: ${action.status}\n'
    '}\n'
  );
  return state
    ..startPageState.isShowDialogJoin = action.status;
}

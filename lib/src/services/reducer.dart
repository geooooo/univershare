import 'package:redux/redux.dart';

import 'app_state.dart';
import 'action.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, SetEventId>(_onSetEventId),
  TypedReducer<AppState, SetUserName>(_onSetUserName),
  TypedReducer<AppState, SendMessage>(_onSendMessage),
  TypedReducer<AppState, CreateEvent>(_onCreateEvent),
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
    'Action: SendMessage {\n'
      '\tuserName: ${action.userName}\n'
      '\teventName: ${action.eventName}\n'
    '}\n'
  );
  return state
    ..userName = action.userName
    ..eventName = action.eventName;
}

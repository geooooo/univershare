import 'package:redux/redux.dart';
import 'package:api_models/api_models.dart' as api_models;

import 'app_state.dart';
import 'action.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, SetEventId>(_onSetEventId),
  TypedReducer<AppState, SetUserName>(_onSetUserName),
  TypedReducer<AppState, SendMessage>(_onSendMessage),
  TypedReducer<AppState, CreateEvent>(_onCreateEvent),
  TypedReducer<AppState, DeleteMessageFromQuestions>(_onDeleteMessageFromQuestions),
  TypedReducer<AppState, Loading>(_onLoading),
  TypedReducer<AppState, SetEventInfo>(_onSetEventInfo),
  TypedReducer<AppState, SocketConnect>(_onSocketConnect),
  TypedReducer<AppState, SaveMessages>(_onSaveMessages),
  TypedReducer<AppState, SocketClose>(_onSocketClose),
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

AppState _onLoading(AppState state, Loading action) {
  print(
    'Action: Loading {\n'
      '\tisShow: ${action.isShow}\n'
    '}\n'
  );
  return state
    ..isLoadingShow = action.isShow;
}

AppState _onSetEventInfo(AppState state, SetEventInfo action) {
  print(
    'Action: SetEventInfo {\n'
      '\teventName: ${action.eventName}\n'
      '\tpresentationUrl: ${action.presentationUrl}\n'
      '\tuserId: ${action.userId}\n'
    '}\n'
  );
  return state
    ..eventName = action.eventName
    ..presentationUrl = action.presentationUrl
    ..userId = action.userId;
}

AppState _onSocketConnect(AppState state, SocketConnect action) {
  print(
    'Action: SocketConnect {\n'
      '\tsocket.hasCode: ${action.hashCode}\n'
    '}\n'
  );
  return state
    ..socket = action.socket;
}

AppState _onSaveMessages(AppState state, SaveMessages action) {
  print(
    'Action: SaveMessages {\n'
      '\tmessages.length: ${action.messages.length}\n'
    '}\n'
  );
  return state
    ..messages = action.messages.map((apiMessage) => Message(
      userName: apiMessage.userName,
      isQuestion:  apiMessage.isQuestion,
      text: apiMessage.text,
    ));
}

AppState _onSocketClose(AppState state, SocketClose action) {
  print(
    'Action: SocketClose {}'
  );
  return state
    ..socket.sink.close();
}


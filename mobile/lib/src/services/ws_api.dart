import 'dart:io' as io;

import 'package:redux/redux.dart';
import 'package:api_models/api_models.dart' as api_models;

import 'common.dart' as common;
import '../services/intl.dart' as intl;
import '../services/rest_api.dart' as rest_api;
import '../services/redux/actions.dart' as actions;
import '../services/redux/app_state.dart';
import '../models/message.dart';
import '../widgets/common/dialog_info.dart';

Store<AppState> _store;

Future<void> init(Store<AppState> store) async {
  _store = store;
  final socket = await io.WebSocket.connect(common.ws_host);
  store.dispatch(actions.SetSocket(socket));
  socket.listen((Object data) => _socketListener(data, store));
}

Future<void> _getEventMessages() async {
  final response = await rest_api.getEventMessages(_store.state.eventId);
  _store.dispatch(actions.SaveMessages(response.messages.map((message) => Message(
    text: message.text,
    isQuestion: message.isQuestion,
    userId: message.userId,
    userName: message.userName,
  )).toList()));
}

Future<void> connectListener() async {
  _store.state.socket.add(api_models.WebSocketConnectListener(
    eventId: _store.state.eventId,
    userId: _store.state.userId,
  ).toJson());
  await _getEventMessages();
}

Future<void> connectPresenter() async {
  _store.state.socket.add(api_models.WebSocketConnectPresenter(
    eventId: _store.state.eventId,
    userId: _store.state.userId,
  ).toJson());
  await _getEventMessages();
}

void newMessage() => _store.state.socket.add(
  api_models.WebSocketNewMessage(
    eventId: _store.state.eventId,
    userId: _store.state.userId,
    userName: _store.state.userName,
    isQuestion: _store.state.messages.last.isQuestion,
    text: _store.state.messages.last.text,
).toJson());

void disconnectListener() {
  if (!_store.state.isEventActive) {
    _store.state.socket.add(api_models.WebSocketDisconnectListener(
      eventId: _store.state.eventId,
      userId: _store.state.userId,
    ).toJson());
    _store.dispatch(actions.ExitEvent());
  }
  init(_store);
}

void disconnectPresenter() {
  _store.state.socket.add(api_models.WebSocketDisconnectPresenter(
    eventId: _store.state.eventId,
  ).toJson());
  _store.dispatch(actions.ExitEvent());
  init(_store);
}

Future<void> _socketListener(Object event, Store<AppState> store) async {
  final webSocketEvent = api_models.WebSocketEvent.fromJson(event);

  switch (webSocketEvent.name) {
    case 'event_end':
      await _onEventEnd(event);
      break;
    case 'get_message':
      _onGetMessage(event);
      break;
  }
}

Future<void> _onEventEnd(String event) async {
  api_models.WebSocketEventEnd.fromJson(event);
  await showDialogInfo(
    context: _store.state.context,
    title: intl.warning,
    message: intl.eventEnd,
  );
  _store.dispatch(actions.ExitEvent());
}

void _onGetMessage(String event) {
  final data = api_models.WebSocketGetMessage.fromJson(event);
  _store.dispatch(actions.SaveMessages(<Message>[Message(
    text: data.text,
    isQuestion: data.isQuestion,
    userName: data.userName,
  )]));
}

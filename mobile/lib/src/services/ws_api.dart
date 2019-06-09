import 'dart:io' as io;

import 'package:api_models/api_models.dart' as api_models;
import 'package:redux/redux.dart';

import '../services/redux/actions.dart' as actions;
import '../services/redux/app_state.dart';

import 'common.dart' as common;

Store<AppState> _store;

Future<void> init(Store<AppState> store) async {
  _store = store;
  final socket = await io.WebSocket.connect(common.ws_host);
  store.dispatch(actions.SetSocket(socket));
  socket.listen((Object data) => _socketListener(data, store));
}

void connectListener() {
  final request = api_models.WebSocketConnectListener(
    eventId: _store.state.eventId,
    userId: _store.state.userId,
  ).toJson();
  _store.state.socket.add(request);
}

void connectPresenter() {
  final request = api_models.WebSocketConnectPresenter(
    eventId: _store.state.eventId,
    userId: _store.state.userId,
  ).toJson();
  _store.state.socket.add(request);
}

void _socketListener(Object data, Store<AppState> store) {
  print(data.runtimeType);
  print(data);
}
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

void connectListener() => _store.state.socket.add(
  api_models.WebSocketConnectListener(
    eventId: _store.state.eventId,
    userId: _store.state.userId,
).toJson());

void connectPresenter() => _store.state.socket.add(
  api_models.WebSocketConnectPresenter(
    eventId: _store.state.eventId,
    userId: _store.state.userId,
).toJson());

void newMessage() => _store.state.socket.add(
  api_models.WebSocketNewMessage(
    eventId: _store.state.eventId,
    userId: _store.state.userId,
    userName: _store.state.userName,
    isQuestion: _store.state.messages.last.isQuestion,
    text: _store.state.messages.last.text,
).toJson());

void _socketListener(Object data, Store<AppState> store) {
  print(data.runtimeType);
  print(data);
}

//  Future<void> _init() async {
//    final socket = await io.WebSocket.connect(data.ws_host);
//    final requestData = conv.jsonEncode((api_models.WebSocketEvent()
//      ..name = 'connect'
//      ..data = (api_models.WebSocketConnectData()
//        ..userId = store.state.userId
//        ..eventId = store.state.eventId)
//    ).asMap());
//    socket.add(requestData);
//    store.dispatch(action.SocketConnect(socket));
//
//    socket.listen(_socketListener);
//
//
//  }
//
//  Future<void> _socketListener(Object jsonData) async {
//    print('+++++');
//    print(jsonData);
//    final data = conv.jsonDecode(jsonData);
//    final eventName = data['name'];
//    final eventData = data['data'];
//
//    switch (eventName) {
//      case 'event_end':
//        _onEventEnd(eventData);
//        break;
//      case 'get_message':
//        _onGetMessage(eventData);
//        break;
//    }
//  }
//
//  void _onEventEnd(Map<String, Object> eventData) {
//    store.dispatch(action.SocketClose());
////    showDialogWarning(context, intl.eventEnd);
//  }
//
//  void _onGetMessage(Map<String, Object> eventData) {
//    print(eventData);
//    final data = api_models.WebSocketGetMessageData()..readFromMap(eventData);
//    store.dispatch(action.SaveMessages(<api_models.Message>[
//      api_models.Message()
//        ..text = data.text
//        ..isQuestion = data.isQuestion
//        ..userName = data.userName
//    ]));
//  }



//  Future<void> _init() async {
//    final socket = await io.WebSocket.connect(data.ws_host);
//    final requestData = conv.jsonEncode((api_models.WebSocketEvent()
//      ..name = 'connect'
//      ..data = (api_models.WebSocketConnectData()
//        ..userId = store.state.userId
//        ..eventId = store.state.eventId)
//    ).asMap());
//    socket.add(requestData);
//    store.dispatch(action.SocketConnect(socket));
//
//    socket.listen(_socketListener);
//
//    final responseData = await rest_api.getEventMessages(store.state.eventId);
//    store.dispatch(action.SaveMessages(responseData.messages));
//  }
//
//  Future<void> _socketListener(Object jsonData) async {
//    print('+++++');
//    print(jsonData);
//    final data = conv.jsonDecode(jsonData);
//    final eventName = data['name'];
//    final eventData = data['data'];
//
//    switch (eventName) {
//      case 'get_message':
//        _onGetMessage(eventData);
//        break;
//    }
//  }
//
//  void _onGetMessage(Map<String, Object> eventData) {
//    final data = api_models.WebSocketGetMessageData()..readFromMap(eventData);
//    store.dispatch(action.SaveMessages(<api_models.Message>[
//      api_models.Message()
//        ..text = data.text
//        ..isQuestion = data.isQuestion
//        ..userName = data.userName
//    ]));
//  }

//}


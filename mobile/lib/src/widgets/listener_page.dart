import 'dart:io' as io;
import 'dart:convert' as conv;

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:api_models/api_models.dart' as api_models;

//import '../services/intl.dart' as intl;
import '../services/data.dart' as data;
import '../services/rest_api.dart' as rest_api;
import '../services/redux/action.dart' as action;
import '../services/redux/app_state.dart';
import 'page_chat.dart';
import 'listener_page_control.dart';
import 'listener_page_presentation.dart';
//import 'dialog_warning.dart';

var f = false;

class ListenerPage extends StatelessWidget {

  final Store<AppState> store;

  ListenerPage({
    this.store,
  }) {
    if (!f) {
      _init();
      f = true;
    }
  }

  Future<void> _init() async {
    final socket = await io.WebSocket.connect(data.ws_host);
    final requestData = conv.jsonEncode((api_models.WebSocketEvent()
      ..name = 'connect'
      ..data = (api_models.WebSocketConnectData()
        ..userId = store.state.userId
        ..eventId = store.state.eventId)
    ).asMap());
    socket.add(requestData);
    store.dispatch(action.SocketConnect(socket));

    socket.listen(_socketListener);

    final responseData = await rest_api.getEventMessages(store.state.eventId);
    store.dispatch(action.SaveMessages(responseData.messages));
  }

  Future<void> _socketListener(Object jsonData) async {
    print('+++++');
    print(jsonData);
    final data = conv.jsonDecode(jsonData);
    final eventName = data['name'];
    final eventData = data['data'];

    switch (eventName) {
      case 'event_end':
        _onEventEnd(eventData);
        break;
      case 'get_message':
        _onGetMessage(eventData);
        break;
    }
  }

  void _onEventEnd(Map<String, Object> eventData) {
    store.dispatch(action.SocketClose());
//    showDialogWarning(context, intl.eventEnd);
  }

  void _onGetMessage(Map<String, Object> eventData) {
    print(eventData);
    final data = api_models.WebSocketGetMessageData()..readFromMap(eventData);
    store.dispatch(action.SaveMessages(<api_models.Message>[
      api_models.Message()
        ..text = data.text
        ..isQuestion = data.isQuestion
        ..userName = data.userName
    ]));
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          tabs: <Widget>[
            Tab(child: Icon(Icons.settings)),
            Tab(child: Icon(Icons.chat)),
            Tab(child: Icon(Icons.visibility)),
          ],
        ),
        body: TabBarView(
          children: [
            ListenerPageControl(
              store: store,
            ),
            PageChat(
              store: store,
              isQuestionEnabled: true,
            ),
            ListenerPagePresentation(
              store: store,
            ),
          ],
        ),
      ),
    ),
  );

}


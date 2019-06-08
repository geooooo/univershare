import 'dart:convert' as conv;

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'dart:io' as io;
import 'package:api_models/api_models.dart' as api_models;

import '../services/data.dart' as data;
import '../services/rest_api.dart' as rest_api;
import '../services/redux/action.dart' as action;
import 'package:mobile/src/services/redux/app_state.dart';
import 'page_chat.dart';
import 'presenter_page_control.dart';
import 'presenter_page_questions.dart';

var f = false;

class PresenterPage extends StatelessWidget {

  final Store<AppState> store;

  PresenterPage({
    this.store,
  }) {
    if (!f) {
      _init();
      f = true;
    }
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
            Tab(child: Icon(Icons.list)),
          ],
        ),
        body: TabBarView(
          children: [
            PresenterPageControl(
              store: store,
            ),
            PageChat(
              store: store,
              isQuestionEnabled: false,
            ),
            PresenterPageQuestions(
              store: store,
            ),
          ],
        ),
      ),
    ),
  );

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
      case 'get_message':
        _onGetMessage(eventData);
        break;
    }
  }

  void _onGetMessage(Map<String, Object> eventData) {
    final data = api_models.WebSocketGetMessageData()..readFromMap(eventData);
    store.dispatch(action.SaveMessages(<api_models.Message>[
      api_models.Message()
        ..text = data.text
        ..isQuestion = data.isQuestion
        ..userName = data.userName
    ]));
  }

}


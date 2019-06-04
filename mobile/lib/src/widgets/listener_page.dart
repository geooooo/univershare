import 'dart:convert' as conv;

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:web_socket_channel/io.dart';
import 'package:api_models/api_models.dart' as api_models;

import '../services/intl.dart' as intl;
import '../services/data.dart' as data;
import '../services/rest_api.dart' as rest_api;
import '../services/redux/action.dart' as action;
import '../services/redux/app_state.dart';
import 'page_chat.dart';
import 'listener_page_control.dart';
import 'listener_page_presentation.dart';
import 'dialog_warning.dart';

class ListenerPage extends StatefulWidget {

  final Store<AppState> store;

  ListenerPage({
    this.store,
  });

  @override
  State<ListenerPage> createState() => ListenerPageState(
    store: store,
  );

}

class ListenerPageState extends State<ListenerPage> {

  final Store<AppState> store;

  ListenerPageState({
    this.store,
  }) {
    _init();
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

  Future<void> _init() async {
    final socket = IOWebSocketChannel.connect(data.ws_host);
    socket.sink.add(api_models.WebSocketConnectData()
      ..userId = store.state.userId
      ..eventId = store.state.eventId
    );
    store.dispatch(action.SocketConnect(socket));

    socket.stream.listen(_socketListener);

    final responseData = await rest_api.getEventMessages(store.state.eventId);
    store.dispatch(action.SaveMessages(responseData.messages));
  }

  Future<void> _socketListener(Object jsonData) async {
    final data = conv.jsonDecode(jsonData);
    final eventName = data['event'];
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
    showDialogWarning(context, intl.eventEnd);
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


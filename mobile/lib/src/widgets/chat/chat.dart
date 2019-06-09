//import 'dart:convert' as conv;

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
//import 'package:api_models/api_models.dart' as api_models;

import '../../services/redux/actions.dart' as actions;
import '../../services/redux/app_state.dart';
import 'chat_input_field.dart';
import 'chat_messages.dart';

class Chat extends StatelessWidget {

  final Store<AppState> store;
  final bool isQuestionEnabled;

  Chat({
    this.store,
    this.isQuestionEnabled,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      StoreConnector<AppState, Map<String, Object>>(
        converter: (store) => <String, Object>{
          'messages': store.state.messages,
          'current_user_name': store.state.userName,
         },
        builder: (context, data) => ChatMessages(
          messages: data['messages'],
          currentUserName: data['current_user_name'],
        ),
      ),
      ChatInputField(
        isQuestionEnabled: isQuestionEnabled,
        onSendMessage: _onSendMessage,
      ),
    ],
  );

  void _onSendMessage(String value, bool isQuestion) {
//    final requestData = conv.jsonEncode((api_models.WebSocketEvent()
//      ..name = 'new_message'
//      ..data = (api_models.WebSocketNewMessageData()
//        ..userId = store.state.userId
//        ..eventId = store.state.eventId
//        ..userName = store.state.userName
//        ..text = value
//        ..isQuestion = isQuestion)
//    ).asMap());
//    store.state.socket.add(requestData);
    store.dispatch(actions.SendMessage(value, store.state.userName, isQuestion));
  }

}
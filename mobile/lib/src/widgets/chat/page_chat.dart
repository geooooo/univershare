//import 'dart:convert' as conv;
//
//import 'package:flutter/material.dart';
//import 'package:redux/redux.dart';
//import 'package:api_models/api_models.dart' as api_models;
//
//import 'package:mobile/src/services/redux/app_state.dart';
//import 'package:mobile/src/services/redux/actions.dart' as action;
//import 'chat_input_field.dart';
//import 'chat_messages.dart';
//
//class PageChat extends StatelessWidget {
//
//  final Store<AppState> store;
//  final bool isQuestionEnabled;
//
//  PageChat({
//    this.store,
//    this.isQuestionEnabled,
//  });
//
//  @override
//  Widget build(BuildContext context) => Column(
//    mainAxisSize: MainAxisSize.max,
//    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//    children: <Widget>[
//      ChatMessages(
//        store: store,
//      ),
//      ChatInputField(
//        isQuestionEnabled: isQuestionEnabled,
//        onSendMessage: _onSendMessage,
//      )
//    ],
//  );
//
//  void _onSendMessage(String value, bool isQuestion) {
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
//    store.dispatch(action.SendMessage(value, store.state.userName, isQuestion));
//  }
//
//}
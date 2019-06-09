import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../services/ws_api.dart' as ws_api;
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
          'current_user_id': store.state.userId,
         },
        builder: (context, data) => ChatMessages(
          messages: data['messages'],
          currentUserId: data['current_user_id'],
        ),
      ),
      ChatInputField(
        isQuestionEnabled: isQuestionEnabled,
        onSendMessage: _onSendMessage,
      ),
    ],
  );

  void _onSendMessage(String value, bool isQuestion) {
    store.dispatch(actions.SendMessage(value, store.state.userName, isQuestion));
    ws_api.newMessage();
  }

}
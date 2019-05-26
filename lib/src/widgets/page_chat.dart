import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../services/app_state.dart';
import '../services/action.dart' as action;
import 'chat_input_field.dart';
import 'chat_messages.dart';

class PageChat extends StatelessWidget {

  final Store<AppState> store;
  final bool isQuestionEnabled;

  PageChat({this.store, this.isQuestionEnabled});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      ChatMessages(
        store: store,
      ),
      ChatInputField(
        isQuestionEnabled: isQuestionEnabled,
        onSendMessage: _onSendMessage,
      )
    ],
  );

  void _onSendMessage(String value, bool isQuestion) {
    store.dispatch(action.SendMessage(value, store.state.userName, isQuestion));
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:mobile/src/services/redux/app_state.dart';
import 'package:mobile/src/services/redux/action.dart' as action;

class PresenterPageQuestions extends StatefulWidget {

  final Store<AppState> store;

  PresenterPageQuestions({
    this.store,
  });

  @override
  State<PresenterPageQuestions> createState() => PresenterPageQuestionsState();

}

class PresenterPageQuestionsState extends State<PresenterPageQuestions> {

  final Store<AppState> store;

  PresenterPageQuestionsState({
    this.store,
  });

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, Map<String, Object>>(
    converter: (store) => <String, Object>{
      'messages': store.state.messages.where((message) => message.isQuestion).toList(),
      'callback': (message) => store.dispatch(action.DeleteMessageFromQuestions(message)),
    },
    builder: (context, data) {
      final messages = data['messages'] as List<Message>;
      final callback = data['callback'] as Function;
      return ListView.builder(
        itemCount: messages.length * 2 - 1,
        itemBuilder: (BuildContext context, int index) {
          final message = messages[index ~/ 2];
          return (index & 1 == 1) ? Divider() : ListTile(
            title: Text(message.text),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => callback(message),
            ),
          );
        }
      );
    }
  );

}
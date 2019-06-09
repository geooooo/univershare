import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../services/redux/app_state.dart';
import '../../services/redux/actions.dart' as actions;
import '../../models/message.dart';

class PresenterPageQuestions extends StatefulWidget {

  final Store<AppState> store;

  PresenterPageQuestions({
    this.store,
  });

  @override
  State<PresenterPageQuestions> createState() => PresenterPageQuestionsState(
    store: store,
  );

}

class PresenterPageQuestionsState extends State<PresenterPageQuestions> {

  final Store<AppState> store;

  PresenterPageQuestionsState({
    this.store,
  });

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, List<Message>>(
    converter: (store) => store.state.messages.where(
      (message) => message.isQuestion && !message.isChecked
    ).toList()..addAll(store.state.messages.where(
      (message) => message.isQuestion && message.isChecked
    )),
    builder: (context, messages) => ListView.builder(
      itemCount: messages.length * 2 - 1,
      itemBuilder: (BuildContext context, int index) {
        final messageIndex = index ~/ 2;
        final message = messages[messageIndex];
        final iconButton = IconButton(
          highlightColor: message.isChecked? Colors.grey : Colors.lightGreenAccent,
          splashColor: message.isChecked? Colors.grey : Colors.lightGreenAccent,
          icon: Icon(
            Icons.done,
            color: message.isChecked? Colors.lightGreenAccent : Colors.grey,
          ),
          onPressed: () => _onDeleteQuestion(message),
        );
        return (index & 1 == 1) ? Divider() : ListTile(
          title: Text(
            message.userName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.lightBlueAccent,
            ),
          ),
          subtitle: Text(message.text),
          trailing: iconButton,
        );
      }
    ),
  );

  void _onDeleteQuestion(Message message) {
    store.dispatch(actions.CheckQuestion(message));
  }

}
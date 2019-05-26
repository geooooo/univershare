import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../services/app_state.dart';
import 'chat_message.dart';

class ChatMessages extends StatefulWidget {

  final Store<AppState> store;
  final ScrollController scrollController;

  ChatMessages({this.store, this.scrollController});

  @override
  State<ChatMessages> createState() => ChatMessagesState();

}

class ChatMessagesState extends State<ChatMessages> {

  final Store<AppState> store;
  final ScrollController _scrollController = ScrollController();

  ChatMessagesState({this.store});

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (mounted) {
        timer.cancel();
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Expanded(
    child: StoreConnector<AppState, Map<String, Object>>(
      converter: (store) => <String, Object>{
        'messages': store.state.messages,
        'current_user_name': store.state.userName,
      },
      builder: (context, data) => ListView(
        controller: _scrollController,
        children: (data['messages'] as List<Message>).map((message) => ChatMessage(
          text: message.text,
          userName: message.userName,
          isCurrentUser: data['current_user_name'] == message.userName,
        )).toList(),
      ),
    ),
  );



}
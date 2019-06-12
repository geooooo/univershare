import 'dart:async';

import 'package:flutter/material.dart';

import '../../services/intl.dart' as intl;
import '../../models/message.dart';
import 'chat_message.dart';

class ChatMessages extends StatefulWidget {

  final int currentUserId;
  final List<Message> messages;

  ChatMessages({
    this.currentUserId,
    this.messages,
  });

  @override
  State<ChatMessages> createState() => ChatMessagesState(
    currentUserId: currentUserId,
    messages: messages,
  );

}

class ChatMessagesState extends State<ChatMessages> {

  ScrollController _scrollController;
  final int currentUserId;
  final List<Message> messages;

  ChatMessagesState({
    this.currentUserId,
    this.messages,
  });

  @override
  void initState() {
    super.initState();
    _scheduleScrollToBottom();
  }

  @override
  void didUpdateWidget(ChatMessages oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scheduleScrollToBottom();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      color: Colors.white10,
      child: Center(
        child: messages.isEmpty? Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.message,
              color: Colors.white24,
              size: 200,
            ),
            Text(
              intl.writeFirstMessage,
              style: TextStyle(
                color: Colors.white24,
                fontSize: 20,
              ),
            )
          ]
        ): ListView(
          controller: _scrollController,
          children: messages.map((message) => ChatMessage(
            text: message.text,
            userName: message.userName,
            isCurrentUser: currentUserId == message.userId,
          )).toList(),
        ),
      ),
    ),
  );

  void _scheduleScrollToBottom() {
    if (messages.isEmpty) {
      return;
    }
    _scrollController = ScrollController();
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (mounted) {
        timer.cancel();
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

}
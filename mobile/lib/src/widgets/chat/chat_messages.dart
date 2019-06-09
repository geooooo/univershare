import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/message.dart';
import 'chat_message.dart';

class ChatMessages extends StatefulWidget {

  final String currentUserName;
  final List<Message> messages;

  ChatMessages({
    this.currentUserName,
    this.messages,
  });

  @override
  State<ChatMessages> createState() => ChatMessagesState(
    currentUserName: currentUserName,
    messages: messages,
  );

}

class ChatMessagesState extends State<ChatMessages> {

  ScrollController _scrollController;
  final String currentUserName;
  final List<Message> messages;

  ChatMessagesState({
    this.currentUserName,
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
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      color: Colors.white10,
      child: ListView(
        controller: _scrollController,
        children: messages.map((message) => ChatMessage(
          text: message.text,
          userName: message.userName,
          isCurrentUser: currentUserName == message.userName,
        )).toList(),
      ),
    ),
  );

  void _scheduleScrollToBottom() {
    _scrollController = ScrollController();
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (mounted) {
        timer.cancel();
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

}
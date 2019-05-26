import 'package:flutter/material.dart';

import '../services/intl.dart' as intl;

typedef void ChatInputFieldOnSendMessageFunction(String value, bool isQuestion);

class ChatInputField extends StatefulWidget {

  final bool isQuestionEnabled;
  final ChatInputFieldOnSendMessageFunction onSendMessage;

  ChatInputField({
    this.onSendMessage,
    this.isQuestionEnabled = false,
  });

  @override
  State<ChatInputField> createState() => ChatInputFieldState(
    onSendMessage: onSendMessage,
    isQuestionEnabled: isQuestionEnabled,
  );

}

class ChatInputFieldState extends State<ChatInputField> {

  final bool isQuestionEnabled;
  final ChatInputFieldOnSendMessageFunction onSendMessage;
  int _maxLines = 1;
  String _value = '';
  final TextEditingController _controller = new TextEditingController();

  ChatInputFieldState({
    this.onSendMessage,
    this.isQuestionEnabled,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      Expanded(
        child: TextField(
          controller: _controller,
          maxLines: _maxLines,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: intl.yourMessage,
          ),
          onTap: _onTap,
          onChanged: _onChanged,
//          onEditingComplete: _onSaved,
        ),
      ),
      IconButton(
        icon: Icon(Icons.pan_tool),
        onPressed: () => _onSendMessage(true),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () => _onSendMessage(false),
      ),
    ],
  );

  void _onSendMessage(bool isQuestion) {
    FocusScope.of(context).detach();
    _controller.clear();
    setState(() {
      _maxLines = 1;
    });
    onSendMessage(_value, isQuestion);
  }

  void _onTap() {
    setState(() {
      _maxLines = 3;
    });
  }

  void _onChanged(String value) {
    _value = value;
  }

}
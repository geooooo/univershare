import 'package:flutter/material.dart';

import '../../services/intl.dart' as intl;

typedef void ChatInputFieldOnSendMessageFunction(String value, bool isQuestion);

class ChatInputField extends StatefulWidget {

  final bool isQuestionEnabled;
  final ChatInputFieldOnSendMessageFunction onSendMessage;
  final bool isEventActive;

  ChatInputField({
    this.onSendMessage,
    this.isQuestionEnabled,
    this.isEventActive,
  });

  @override
  State<ChatInputField> createState() => ChatInputFieldState(
    onSendMessage: onSendMessage,
    isQuestionEnabled: isQuestionEnabled,
    isEventActive: isEventActive,
  );

}

class ChatInputFieldState extends State<ChatInputField> {

  final bool isQuestionEnabled;
  final ChatInputFieldOnSendMessageFunction onSendMessage;
  int _maxLines = 1;
  String _value = '';
  final TextEditingController _controller = new TextEditingController();
  final bool isEventActive;

  ChatInputFieldState({
    this.onSendMessage,
    this.isQuestionEnabled,
    this.isEventActive,
  });

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    foregroundDecoration: BoxDecoration(
      color: Colors.black12,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black12,
          blurRadius: 2,
          spreadRadius: 1,
          offset: Offset(0, -2),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller,
            maxLines: _maxLines,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: intl.yourMessage,
            ),
            onTap: _onTap,
            onChanged: _onChanged,
          ),
        ),
        isQuestionEnabled? IconButton(
          icon: Icon(
            Icons.pan_tool,
            color: Colors.lightBlueAccent,
          ),
          onPressed: isEventActive? () => _onSendMessage(true) : null,
        ) : Container(),
        IconButton(
          icon: Icon(
            Icons.send,
            color: Colors.lightBlueAccent,
          ),
          onPressed: isEventActive? () => _onSendMessage(false) : null,
        ),
      ],
    ),
  );

  void _onSendMessage(bool isQuestion) {
    if (_value.isNotEmpty) {
      onSendMessage(_value, isQuestion);
    }
    FocusScope.of(context).detach();
    setState(() {
      _controller.clear();
      _maxLines = 1;
      _value = '';
    });
  }

  void _onTap() => setState(() {
    _maxLines = 3;
  });

  void _onChanged(String value) => setState(() {
    _value = value.trim();
  });

}
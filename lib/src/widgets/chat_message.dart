import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  final String userName;
  final String text;
  final bool isCurrentUser;

  ChatMessage({
    this.userName,
    this.text,
    this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: isCurrentUser? BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ) : BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Colors.white.withAlpha(50),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              userName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isCurrentUser? Colors.blueAccent : Colors.deepOrangeAccent,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ]
        ),
      ),
    ],
  );

}
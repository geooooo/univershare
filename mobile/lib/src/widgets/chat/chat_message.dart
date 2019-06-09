//import 'package:flutter/material.dart';
//
//class ChatMessage extends StatelessWidget {
//
//  final String userName;
//  final String text;
//  final bool isCurrentUser;
//
//  ChatMessage({
//    this.userName,
//    this.text,
//    this.isCurrentUser,
//  });
//
//  @override
//  Widget build(BuildContext context) => Column(
//    crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end : CrossAxisAlignment.start,
//    children: <Widget>[
//      Container(
//        margin: EdgeInsets.symmetric(
//          vertical: 10,
//        ),
//        padding: EdgeInsets.only(
//          left: isCurrentUser? 10 : 20,
//          right: isCurrentUser? 20 : 10,
//          top: 10,
//          bottom: 10,
//        ),
//        foregroundDecoration: BoxDecoration(
//          borderRadius: isCurrentUser? BorderRadius.only(
//            topLeft: Radius.circular(20),
//            bottomLeft: Radius.circular(20),
//          ) : BorderRadius.only(
//            topRight: Radius.circular(20),
//            bottomRight: Radius.circular(20),
//          ),
//          color: Colors.white.withAlpha(50),
//        ),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Container(
//              margin: EdgeInsets.only(
//                  bottom: 5,
//              ),
//              child: Text(
//                userName,
//                textAlign: TextAlign.right,
//                style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  color: isCurrentUser? Colors.blueAccent : Colors.orangeAccent,
//                ),
//              ),
//            ),
//            Text(
//              text,
//              style: TextStyle(
//                fontSize: 20,
//              ),
//            ),
//          ]
//        ),
//      ),
//    ],
//  );
//
//}
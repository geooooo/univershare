import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../services/app_state.dart';

class ChatMessages extends StatelessWidget {

  final Store<AppState> store;

  ChatMessages({this.store});

  @override
  Widget build(BuildContext context) => Expanded(
    child: ListView(
      children: <Widget>[
        Container(child:Text('+')),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
        Text('1'),
      ],
    ),
  );

}
import 'package:flutter/material.dart';

import '../services/intl.dart' as intl;
import 'vertical_space.dart';
import 'event_id.dart';
import 'dialog_join.dart';

class StartPage extends StatefulWidget {

  @override
  State<StartPage> createState() => StartPageState();

}

class StartPageState extends State<StartPage> {

  String _eventId = '';
  bool _isJoinButtonDisabled = true;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          EventId(
            onChanged: _onChangedEventId,
          ),
          VerticalSpace(10),
          RaisedButton(
            child: Text(intl.join),
            onPressed: (_isJoinButtonDisabled)? null : _onPressedJoinButton,
          ),
          VerticalSpace(20),
          Text(intl.or),
          VerticalSpace(20),
          RaisedButton(
            child: Text(intl.createEvent),
            onPressed: _onPressedCreateButton,
          ),
        ],
      ),
    ),
  );

  void _onPressedJoinButton() {
    _showDialogJoin();
  }

  void _onPressedCreateButton() {}

  void _onChangedEventId(String id) {
    setState(() {
      _eventId = id;
      _isJoinButtonDisabled = id.isEmpty;
    });
  }

  void _showDialogJoin() => showDialog(
    context: context,
    builder: (BuildContext context) => DialogJoin(
      eventId: _eventId,
    ),
  );

}


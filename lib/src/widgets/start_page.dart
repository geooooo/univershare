import 'package:flutter/material.dart';

import '../services/intl.dart' as intl;
import 'vertical_space.dart';
import 'event_id.dart';

class StartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child:Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EventId(),
            VerticalSpace(10),
            RaisedButton(
              child: Text(intl.join),
              onPressed: _onPressedJoinButton,
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
    ),
  );

  void _onPressedJoinButton() {}

  void _onPressedCreateButton() {}

}


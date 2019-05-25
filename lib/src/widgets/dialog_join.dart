import 'package:flutter/material.dart';

import '../services/routes.dart' as routes;
import '../services/intl.dart' as intl;

class DialogJoin extends StatefulWidget {

  final String eventId;

  DialogJoin({this.eventId});

  @override
  State<DialogJoin> createState() => DialogJoinState(
    eventId: eventId,
  );

}

class DialogJoinState extends State<DialogJoin> {

  final String eventId;
  String _name = '';

  DialogJoinState({this.eventId});

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(intl.yourName),
    content: TextField(
      autofocus: true,
      onChanged: _onChangedName,
    ),
    actions: <Widget>[
      FlatButton(
        child: Text(intl.cancel),
        onPressed: () => _onPressedCancel(context),
      ),
      FlatButton(
        child: Text(intl.join),
        onPressed: () => _onPressedJoin(context),
      ),
    ],
  );

  void _onPressedJoin(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushNamed(
        context,
        routes.listenerRoute,
        arguments: routes.ListenerRouteData(
          userName: _name,
          eventId: eventId,
        )
    );
    print([_name, eventId]);
  }

  void _onPressedCancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onChangedName(String value) {
    setState(() {
      _name = value;
    });
  }

}
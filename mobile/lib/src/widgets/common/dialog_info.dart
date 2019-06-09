import 'package:flutter/material.dart';

import '../../services/intl.dart' as intl;

Future<Widget> showDialogInfo({BuildContext context, String title, String message}) async =>
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(intl.ok),
        ),
      ],
    ),
  );
import 'package:flutter/material.dart';

import '../services/intl.dart' as intl;

Future<Widget> showDialogWarning(BuildContext context, String message) async =>
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(intl.warning),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(intl.ok),
        ),
      ],
    ),
  );
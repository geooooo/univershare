import 'package:flutter/material.dart';

import '../services/intl.dart' as intl;

Future<void> showDialogError(BuildContext context, String message) async =>
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(intl.error),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(intl.ok),
        ),
      ],
    ),
  );
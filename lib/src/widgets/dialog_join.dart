import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/route.dart' as routes;
import '../services/intl.dart' as intl;

typedef void DialogJoinOnPressedJoinFunction(String name);

class DialogJoin extends StatefulWidget {

  final DialogJoinOnPressedJoinFunction onPressedJoin;

  DialogJoin({this.onPressedJoin});

  @override
  State<DialogJoin> createState() => DialogJoinState(
      onPressedJoin: onPressedJoin,
  );

}

class DialogJoinState extends State<DialogJoin> {

  static const int _maxLength = 12;
  static final RegExp _nameChars = RegExp(
    r'[a-z_]',
    caseSensitive: false,
  );

  final DialogJoinOnPressedJoinFunction onPressedJoin;
  bool _errorVisible = false;
  bool _isJoinButtonDisabled = true;
  String _name = '';

  DialogJoinState({this.onPressedJoin});

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(intl.yourName),
    content: TextField(
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(_maxLength),
        WhitelistingTextInputFormatter(_nameChars),
      ],
      decoration: InputDecoration(
        errorText: _errorVisible? intl.errorNameEmpty : null,
      ),
      autofocus: true,
      onChanged: _onChangedName,
      onSubmitted: _onSubmittedName,
    ),
    actions: <Widget>[
      FlatButton(
        child: Text(intl.cancel),
        onPressed: () => _onPressedCancel(context),
      ),
      FlatButton(
        child: Text(intl.join),
        onPressed: () => _isJoinButtonDisabled? null : _onPressedJoin(context),
      ),
    ],
  );

  void _onPressedJoin(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushNamed(
      context,
      routes.listenerRoute,
    );
    onPressedJoin(_name);
  }

  void _onPressedCancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onChangedName(String value) {
    setState(() {
      _name = value;
      _isJoinButtonDisabled = _name.isEmpty;
    });
  }

  void _onSubmittedName(String value) {
    setState(() {
      _errorVisible = _name.isEmpty;
    });
  }

}
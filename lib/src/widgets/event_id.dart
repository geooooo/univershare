import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/intl.dart' as intl;

class EventId extends StatelessWidget {

  static const int _maxLength = 11;
//  static const String _separator = '-';
  static final RegExp _hexDecimalChars = RegExp(r'[\da-f]', caseSensitive: false);

  final ValueChanged<String> onSubmitted;

  EventId({this.onSubmitted});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(
      horizontal: 50,
    ),
    child: TextField(
      decoration: InputDecoration(
        labelText: intl.inputIdEvent,
        hintText: intl.idPlaceholder,
      ),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(_maxLength),
        WhitelistingTextInputFormatter(_hexDecimalChars),
      ],
      onChanged: _onChanged,
      onSubmitted: _onSubmitted,
    ),
  );

  void _onChanged(String value) {
//TODO:
//    if ((value.length % 3 == 0) && (value.length < _maxLength)) {
//      value = '$value$_separator';
//    }
  }

  void _onSubmitted(String value) => onSubmitted(value);

}
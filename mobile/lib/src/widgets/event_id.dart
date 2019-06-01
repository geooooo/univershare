import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/intl.dart' as intl;

typedef void EventIdOnChangedFunction(String id, bool isValid);

class EventId extends StatefulWidget {

  final EventIdOnChangedFunction onChanged;

  EventId({
    this.onChanged,
  });

  @override
  State<EventId> createState() => EventIdState(
    onChanged: onChanged,
  );

}

class EventIdState extends State<EventId> {

  static const int _maxLength = 11;
  static final RegExp _hexDecimalChars = RegExp(
    r'[\da-f\-]',
    caseSensitive: false
  );
  static final RegExp _eventIdFormat = RegExp(
    r'^[\da-f]{3}\-[\da-f]{3}\-[\da-f]{3}$',
    caseSensitive: false
  );

  final EventIdOnChangedFunction onChanged;
  bool _errorVisible = false;

  EventIdState({
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(
      horizontal: 50,
    ),
    child: TextField(
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: intl.inputIdEvent,
        hintText: intl.idPlaceholder,
        errorText: _errorVisible? intl.errorEventIdFormat : null,
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
    final isValid = _isValid(value);
    if (isValid) {
      setState(() {
        _errorVisible = false;
      });
    }
    onChanged(value, isValid);
  }

  void _onSubmitted(String value) {
    final isValid = _isValid(value);
    if (!isValid) {
      setState(() {
        _errorVisible = true;
      });
    }
    onChanged(value, isValid);
  }

  bool _isValid(String value) =>
    _eventIdFormat.hasMatch(value);

}
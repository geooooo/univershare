import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';

import '../../services/intl.dart' as intl;
import '../../services/rest_api.dart' as rest_api;
import '../../services/redux/actions.dart' as actions;
import '../../services/route.dart' as route;
import '../../services/redux/app_state.dart';

typedef void DialogJoinOnPressedJoinFunction(String name);

Future<Widget> showDialogJoin({BuildContext context, Store<AppState> store}) async => await showDialog(
  context: context,
  builder: (BuildContext _) => DialogJoin(
    onPressedJoin: (userName) async {
      store.dispatch(actions.Loading(true));
      store.dispatch(actions.SetUserName(userName));
      final response = await rest_api.joinEvent(
        userName: store.state.userName,
        eventId: store.state.eventId,
      );
      store.dispatch(actions.SetEventInfo(response.eventName, response.presentationUrl, response.userId));
      store.dispatch(actions.Loading(false));
      await Navigator.pushNamed(
        context,
        route.listenerRoute,
      );
    },
  ),
);

class DialogJoin extends StatefulWidget {

  final DialogJoinOnPressedJoinFunction onPressedJoin;

  DialogJoin({
    this.onPressedJoin,
  });

  @override
  State<DialogJoin> createState() => DialogJoinState(
    onPressedJoin: onPressedJoin,
  );

}

class DialogJoinState extends State<DialogJoin> {

  static const int _maxLength = 12;
  static final RegExp _nameChars = RegExp(
    r'[a-z_а-я]',
    caseSensitive: false,
  );

  final DialogJoinOnPressedJoinFunction onPressedJoin;
  bool _errorVisible = false;
  bool _isJoinButtonDisabled = true;
  String _name = '';

  DialogJoinState({
    this.onPressedJoin,
  });

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
        onPressed: _onPressedCancel,
      ),
      FlatButton(
        child: Text(intl.join),
        onPressed: _isJoinButtonDisabled? null : _onPressedJoin,
      ),
    ],
  );

  void _onPressedJoin() {
    Navigator.of(context).pop();
    onPressedJoin(_name);
  }

  void _onPressedCancel() => Navigator.of(context).pop();

  void _onChangedName(String value) => setState(() {
    _name = value;
    _isJoinButtonDisabled = _name.isEmpty;
  });

  void _onSubmittedName(String value) => setState(() {
    _errorVisible = _name.isEmpty;
  });

}
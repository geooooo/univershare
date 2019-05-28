import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../services/app_state.dart';
import '../services/intl.dart' as intl;
import '../services/action.dart' as action;
import '../services/route.dart' as route;
import 'vertical_space.dart';
import 'download_presentation.dart';
import 'dialog_error.dart';

class CreateEventPageContent extends StatefulWidget {

  final Store<AppState> store;

  CreateEventPageContent({
    this.store,
  });

  @override
  State<CreateEventPageContent> createState() => CreateEventPageContentState(
    store: store,
  );

}

class CreateEventPageContentState extends State<CreateEventPageContent> {

  static const _maxEventNameLength = 12;
  static final RegExp _eventNameChars = RegExp(
      r'[a-z\_]',
      caseSensitive: false
  );

  final Store<AppState> store;
  String _eventName = '';
  String _userName = '';
  bool _isPresentationLoaded = true;

  CreateEventPageContentState({
    this.store,
  });

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(
      horizontal: 50,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelText: intl.nameEvent,
          ),
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(_maxEventNameLength),
            WhitelistingTextInputFormatter(_eventNameChars),
          ],
          onChanged: _onChangedEventName,
        ),
        VerticalSpace(10),
        TextField(
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelText: intl.yourName,
          ),
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(_maxEventNameLength),
            WhitelistingTextInputFormatter(_eventNameChars),
          ],
          onChanged: _onChangedUserName,
        ),
        VerticalSpace(20),
        StoreConnector<AppState, String>(
          converter: (store) => store.state.eventId,
          builder: (context, eventId) => TextFormField(
            initialValue: eventId,
            decoration: InputDecoration(
              labelText: intl.idEvent,
            ),
            enabled: false,
          ),
        ),
        VerticalSpace(20),
        DownloadPresentation(
          onSelectFile: _onSelectFile,
        ),
        VerticalSpace(30),
        StoreConnector<AppState, VoidCallback>(
          converter: (store) => () => store.dispatch(action.CreateEvent(_eventName, _userName)),
          builder: (context, callback) => RaisedButton(
            child: Text(intl.create),
            onPressed: () => _onPressedCreateButton(callback),
          ),
        ),
      ],
    ),
  );

  void _onChangedEventName(String value) => setState((){
    _eventName = value;
  });

  void _onChangedUserName(String value) => setState((){
    _userName = value;
  });

  Future<void> _onPressedCreateButton(VoidCallback callback) async {
    final allFieldsOk = _eventName.isNotEmpty && _userName.isNotEmpty && _isPresentationLoaded;
    if (!allFieldsOk) {
      await showDialogError(context, intl.createEventError);
      return;
    }
    callback();
    Navigator.pushReplacementNamed(
      context,
      route.presenterRoute,
    );
  }

  void _onSelectFile(String path) => setState(() {
    _isPresentationLoaded = true;
  });

}
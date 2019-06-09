import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../services/ws_api.dart' as ws_api;
import '../../services/intl.dart' as intl;
import '../../services/rest_api.dart' as rest_api;
import '../../services/route.dart' as route;
import '../../services/redux/actions.dart' as actions;
import '../../services/redux/app_state.dart';
import '../common/page.dart';
import '../common/vertical_space.dart';
import '../common/dialog_info.dart';
import 'download_presentation.dart';

class CreateEventPage extends StatefulWidget {

  final Store<AppState> store;

  CreateEventPage({
    this.store,
  });

  @override
  State<CreateEventPage> createState() => CreateEventPageState(
    store: store,
  );

}

class CreateEventPageState extends State<CreateEventPage> {

  static const _maxEventNameLength = 12;
  static final RegExp _eventNameChars = RegExp(
    r'[a-z_а-я]',
    caseSensitive: false
  );
  static const _maxUserNameLength = _maxEventNameLength;
  static final _userNameChars = _eventNameChars;

  final Store<AppState> store;
  String _eventName = '';
  String _userName = '';
  bool _isPresentationLoaded = false;
  List<int> _fileData = [];

  CreateEventPageState({
    this.store,
  });

  @override
  void initState() {
    super.initState();
    _loadEventId();
  }

  @override
  Widget build(BuildContext context) => Page(
    isScroll: true,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: TextField(
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
          margin: EdgeInsets.symmetric(
            horizontal: 50,
          ),
        ),
        VerticalSpace(10),
        Container(
          child: TextField(
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: intl.yourName,
            ),
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(_maxUserNameLength),
              WhitelistingTextInputFormatter(_userNameChars),
            ],
            onChanged: _onChangedUserName,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 50,
          ),
        ),
        VerticalSpace(20),
        StoreConnector<AppState, String>(
          converter: (store) => store.state.eventId,
          builder: (context, eventId) =>Container(
            child: TextFormField(
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: eventId.isEmpty? intl.idEvent : eventId,
              ),
              enabled: false,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 50,
            ),
          ),
        ),
        VerticalSpace(20),
        DownloadPresentation(
          onSelectFile: _onSelectFile,
        ),
        VerticalSpace(30),
        RaisedButton(
          child: Text(intl.create),
          onPressed: _onPressedCreateButton,
        ),
      ],
    ),
  );

  Future<void> _loadEventId() async {
    store.dispatch(actions.Loading(true));
    final response = await rest_api.getNewEventId();
    store.dispatch(actions.SetEventId(response.eventId, true));
    store.dispatch(actions.Loading(false));
  }

  void _onChangedEventName(String value) => setState((){
    _eventName = value;
  });

  void _onChangedUserName(String value) => setState((){
    _userName = value;
  });

  Future<void> _onPressedCreateButton() async {
    final allFieldsOk = _eventName.isNotEmpty && _userName.isNotEmpty && _isPresentationLoaded;
    if (!allFieldsOk) {
      await showDialogInfo(
        context: context,
        title: intl.error,
        message: intl.createEventError,
      );
      return;
    }
    store.dispatch(actions.Loading(true));
    final response = await rest_api.createEvent(
      userName: _userName,
      eventId: store.state.eventId,
      eventName: _eventName,
      presentationFile: _fileData,
    );
    store.dispatch(actions.CreateEvent(_eventName, _userName));
    store.dispatch(actions.SetUserId(response.userId));
    await ws_api.connectPresenter();
    store.dispatch(actions.Loading(false));
    await Navigator.pushReplacementNamed(
      context,
      route.presenterRoute,
    );
  }

  Future<void> _onSelectFile(String path) async {
    final fileData = await io.File(path).readAsBytes();
    setState(() {
      this._fileData = fileData;
      _isPresentationLoaded = true;
    });
  }

}
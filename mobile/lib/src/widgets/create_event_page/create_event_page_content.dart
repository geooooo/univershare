//import 'dart:io' as io;
//
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_redux/flutter_redux.dart';
//import 'package:redux/redux.dart';
//
//import '../services/redux/app_state.dart';
//import '../services/intl.dart' as intl;
//import '../services/redux/actions.dart' as action;
//import '../services/route.dart' as route;
//import '../services/rest_api.dart' as rest_api;
//import 'vertical_space.dart';
//import 'download_presentation.dart';
//import 'dialog_error.dart';
//
//class CreateEventPageContent extends StatefulWidget {
//
//  final Store<AppState> store;
//
//  CreateEventPageContent({
//    this.store,
//  });
//
//  @override
//  State<CreateEventPageContent> createState() => CreateEventPageContentState(
//    store: store,
//  );
//
//}
//
//class CreateEventPageContentState extends State<CreateEventPageContent> {
//
//  static const _maxEventNameLength = 12;
//  static final RegExp _eventNameChars = RegExp(
//      r'[a-z\_]',
//      caseSensitive: false
//  );
//
//  final Store<AppState> store;
//  String _eventName = '';
//  String _userName = '';
//  bool _isPresentationLoaded = true;
//  List<int> fileData = [];
//
//  CreateEventPageContentState({
//    this.store,
//  });
//
//  @override
//  void initState() {
//    super.initState();
//    _loadEventId();
//  }
//
//  @override
//  Widget build(BuildContext context) => Container(
//    margin: EdgeInsets.symmetric(
//      horizontal: 50,
//    ),
//    child: Column(
//      mainAxisSize: MainAxisSize.max,
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        TextField(
//          decoration: InputDecoration(
//            alignLabelWithHint: true,
//            labelText: intl.nameEvent,
//          ),
//          inputFormatters: <TextInputFormatter>[
//            LengthLimitingTextInputFormatter(_maxEventNameLength),
//            WhitelistingTextInputFormatter(_eventNameChars),
//          ],
//          onChanged: _onChangedEventName,
//        ),
//        VerticalSpace(10),
//        TextField(
//          decoration: InputDecoration(
//            alignLabelWithHint: true,
//            labelText: intl.yourName,
//          ),
//          inputFormatters: <TextInputFormatter>[
//            LengthLimitingTextInputFormatter(_maxEventNameLength),
//            WhitelistingTextInputFormatter(_eventNameChars),
//          ],
//          onChanged: _onChangedUserName,
//        ),
//        VerticalSpace(20),
//        StoreConnector<AppState, String>(
//          converter: (store) => store.state.eventId,
//          builder: (context, eventId) => TextFormField(
//            decoration: InputDecoration(
//              alignLabelWithHint: true,
//              labelText: eventId.isEmpty? intl.idEvent : eventId,
//            ),
//            enabled: false,
//          ),
//        ),
//        VerticalSpace(20),
//        DownloadPresentation(
//          onSelectFile: _onSelectFile,
//        ),
//        VerticalSpace(30),
//        RaisedButton(
//          child: Text(intl.create),
//          onPressed: _onPressedCreateButton,
//        ),
//      ],
//    ),
//  );
//
//  Future<void> _loadEventId() async {
//    store.dispatch(action.Loading(true));
//    final response = await rest_api.getNewEventId();
//    store.dispatch(action.SetEventId(response.eventId, true));
//    store.dispatch(action.Loading(false));
//  }
//
//  void _onChangedEventName(String value) => setState((){
//    _eventName = value;
//  });
//
//  void _onChangedUserName(String value) => setState((){
//    _userName = value;
//  });
//
//  Future<void> _onPressedCreateButton() async {
//    final allFieldsOk = _eventName.isNotEmpty && _userName.isNotEmpty && _isPresentationLoaded;
//    if (!allFieldsOk) {
//      await showDialogError(context, intl.createEventError);
//      return;
//    }
//    store.dispatch(action.Loading(true));
//    await rest_api.createEvent(
//      userName: _userName,
//      eventId: store.state.eventId,
//      eventName: _eventName,
//      presentationFile: fileData,
//    );
//    store.dispatch(action.CreateEvent(_eventName, _userName));
//    store.dispatch(action.Loading(false));
//    await Navigator.pushReplacementNamed(
//      context,
//      route.presenterRoute,
//    );
//  }
//
//  Future<void> _onSelectFile(String path) async {
//    final fileData = await io.File(path).readAsBytes();
//    setState(() {
//      this.fileData = fileData;
//      _isPresentationLoaded = true;
//    });
//  }
//
//}
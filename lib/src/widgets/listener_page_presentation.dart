import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/app_state.dart';
import '../services/intl.dart' as intl;

class ListenerPagePresentation extends StatelessWidget {

  final Store<AppState> store;

  ListenerPagePresentation({this.store});

  @override
  Widget build(BuildContext context) => Container(
    child: Center(
      child: RaisedButton(
        onPressed: () => _openPresentation(context),
        child: Text(intl.openPresentation),
      ),
    ),
  );

  Future<void> _openPresentation(BuildContext context) async {
    final url = store.state.presentationUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showDialogError(context);
    }
  }

  void _showDialogError(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(intl.error),
      content: Text(intl.openPresentationError),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(intl.ok),
        ),
      ],
    ),
  );

}
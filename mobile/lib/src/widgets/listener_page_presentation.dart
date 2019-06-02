import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mobile/src/services/redux/app_state.dart';
import '../services/intl.dart' as intl;
import 'dialog_error.dart';

class ListenerPagePresentation extends StatelessWidget {

  final Store<AppState> store;

  ListenerPagePresentation({
    this.store,
  });

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
      await showDialogError(context, intl.openPresentationError);
    }
  }

}
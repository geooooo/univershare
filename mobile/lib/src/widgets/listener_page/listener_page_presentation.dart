import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/intl.dart' as intl;
import '../common/dialog_info.dart';

class ListenerPagePresentation extends StatelessWidget {

  final String presentationUrl;

  ListenerPagePresentation({
    this.presentationUrl,
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
    final url = presentationUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await showDialogInfo(
        context: context,
        title: intl.error,
        message: intl.openPresentationError,
      );
    }
  }

}
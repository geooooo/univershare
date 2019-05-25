import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../services/intl.dart' as intl;
import '../services/asset.dart' as asset;
import '../services/app_state.dart';
import 'vertical_space.dart';
import 'event_id.dart';
import 'dialog_join.dart';

class StartPageContent extends StatelessWidget {

  static const double _logoSize = 150;

  final Store<AppState> store;
  bool _isJoinButtonDisabled = true;

  StartPageContent({this.store});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image(
        image: AssetImage(asset.icon),
        height: _logoSize,
        width: _logoSize,
      ),
      VerticalSpace(30),
      EventId(
        onChanged: _onChangedEventId,
      ),
      VerticalSpace(20),
      RaisedButton(
        child: Text(intl.join),
        onPressed: (_isJoinButtonDisabled)? null : _onPressedJoinButton,
      ),
      VerticalSpace(30),
      Text(intl.or),
      VerticalSpace(30),
      RaisedButton(
        child: Text(intl.createEvent),
        onPressed: _onPressedCreateButton,
      ),
    ],
  );

  void _onPressedJoinButton() {
//    _showDialogJoin();
  }

  void _onPressedCreateButton() {}

  void _onChangedEventId(String id) {
//    setState(() {
//      _eventId = id;
//      _isJoinButtonDisabled = id.isEmpty;
//    });
  }

//  void _showDialogJoin() => showDialog(
//    context: context,
//    builder: (BuildContext context) => DialogJoin(
//      eventId: _eventId,
//    ),
//  );


}
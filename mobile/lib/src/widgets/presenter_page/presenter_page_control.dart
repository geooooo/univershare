import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../services/ws_api.dart' as ws_api;
import '../../services/intl.dart' as intl;
import '../../services/route.dart' as route;
import '../../services/redux/app_state.dart';
import '../common/vertical_space.dart';
import '../common/event_info.dart';

class PresenterPageControl extends StatelessWidget {

  final Store<AppState> store;

  PresenterPageControl({
    this.store,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      StoreConnector<AppState, Map<String, Object>>(
        converter: (store) => <String, Object>{
          'event_name': store.state.eventName,
          'event_id': store.state.eventId,
          'user_name': store.state.userName,
        },
        builder: (context, data) => EventInfo(
          eventName: data['event_name'],
          eventId: data['event_id'],
          userName: data['user_name'],
        ),
      ),
      VerticalSpace(30),
      RaisedButton(
        child: Text(intl.completeEvent),
        onPressed: () => _onPressedCompleteButton(context),
      ),
    ],
  );

  void _onPressedCompleteButton(BuildContext context) {
    ws_api.disconnectPresenter();
    Navigator.pushReplacementNamed(
      context,
      route.startPageRoute,
    );
  }

}
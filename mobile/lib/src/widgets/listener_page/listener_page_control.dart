import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../services/intl.dart' as intl;
import '../../services/route.dart' as route;
import '../../services/ws_api.dart' as ws_api;
import 'package:mobile/src/services/redux/app_state.dart';
import '../common/event_info.dart';
import '../common/vertical_space.dart';

class ListenerPageControl extends StatelessWidget {

  final Store<AppState> store;

  ListenerPageControl({
    this.store,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      StoreConnector<AppState, Map<String, Object>>(
        converter: (store) => <String, Object>{
          'event_id': store.state.eventId,
          'event_name': store.state.eventName,
        },
        builder: (context, data) => EventInfo(
          eventId: data['event_id'],
          eventName: data['event_name'],
        ),
      ),
      VerticalSpace(30),
      RaisedButton(
        child: Text(intl.leaveEvent),
        onPressed: () => _onPressedExitButton(context),
      ),
    ],
  );

  Future<void> _onPressedExitButton(BuildContext context) async {
    ws_api.disconnectListener();
    await Navigator.pushReplacementNamed(
      context,
      route.startPageRoute,
    );
  }

}
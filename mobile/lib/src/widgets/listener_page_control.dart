import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:api_models/api_models.dart' as api_models;

import '../services/intl.dart' as intl;
import '../services/route.dart' as route;
import '../services/redux/action.dart' as action;
import 'package:mobile/src/services/redux/app_state.dart';
import 'vertical_space.dart';
import 'event_info.dart';

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
      EventInfo(
        store: store,
      ),
      VerticalSpace(30),
      RaisedButton(
        child: Text(intl.leaveEvent),
        onPressed: () => _onPressedExitButton(context),
      ),
    ],
  );

  Future<void> _onPressedExitButton(BuildContext context) async {
    store.state.socket.sink.add(api_models.WebSocketDisconnectListenerData()
      ..userId = store.state.userId
      ..eventId = store.state.eventId
    );
    store.dispatch(action.SocketClose());
    await Navigator.pushReplacementNamed(
      context,
      route.startPageRoute,
    );
  }

}
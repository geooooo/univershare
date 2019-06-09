//import 'dart:convert' as conv;

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
//import 'package:api_models/api_models.dart' as api_models;

import '../../services/intl.dart' as intl;
import '../../services/route.dart' as route;
//import '../../services/redux/actions.dart' as actions;
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
        },
        builder: (context, data) => EventInfo(
          eventName: data['event_name'],
          eventId: data['event_id'],
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
//    final requestData = conv.jsonEncode((api_models.WebSocketEvent()
//      ..name = 'disconnect_presenter'
//      ..data = (api_models.WebSocketDisconnectPresenterData()
//        ..userId = store.state.userId
//        ..eventId = store.state.eventId
//        ..userId = store.state.userId
//        ..eventId = store.state.eventId)
//    ).asMap());
//    store.state.socket.add(requestData);
//    store.dispatch(action.SocketClose());
    Navigator.pushReplacementNamed(
      context,
      route.startPageRoute,
    );
  }

}
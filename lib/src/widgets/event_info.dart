import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../services/intl.dart' as intl;
import '../services/app_state.dart';
import 'vertical_space.dart';

class EventInfo extends StatelessWidget {

  final Store<AppState> store;

  EventInfo({this.store});

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(
      horizontal: 50,
    ),
    child: Column(
      children: <Widget>[
        StoreConnector<AppState, String>(
          converter: (store) => store.state.eventName,
          builder: (context, eventName) => TextFormField(
            initialValue: eventName,
            decoration: InputDecoration(
              labelText: intl.nameEvent,
            ),
            enabled: false,
          ),
        ),
        VerticalSpace(20),
        StoreConnector<AppState, String>(
          converter: (store) => store.state.eventId,
          builder: (context, eventId) => TextFormField(
            initialValue: eventId,
            decoration: InputDecoration(
              labelText: intl.idEvent,
            ),
            enabled: false,
          ),
        ),
      ],
    )
  );

}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../services/intl.dart' as intl;
import '../services/route.dart' as route;
import '../services/app_state.dart';
import 'vertical_space.dart';

class ListenerPageControl extends StatelessWidget {

  final Store<AppState> store;

  ListenerPageControl({this.store});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
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
      ),
      VerticalSpace(30),
      RaisedButton(
        child: Text(intl.leaveEvent),
        onPressed: () => _onPressedExitButton(context),
      ),
    ],
  );

  void _onPressedExitButton(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      route.startPageRoute,
    );
  }

}
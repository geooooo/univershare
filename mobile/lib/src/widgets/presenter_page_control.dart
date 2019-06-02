import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../services/intl.dart' as intl;
import '../services/route.dart' as route;
import 'package:mobile/src/services/redux/app_state.dart';
import 'vertical_space.dart';
import 'event_info.dart';

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
      EventInfo(
        store: store,
      ),
      VerticalSpace(30),
      RaisedButton(
        child: Text(intl.completeEvent),
        onPressed: () => _onPressedCompleteButton(context),
      ),
    ],
  );

  void _onPressedCompleteButton(BuildContext context) => Navigator.pushReplacementNamed(
    context,
    route.startPageRoute,
  );

}
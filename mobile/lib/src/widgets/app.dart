import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../services/route.dart';
import '../services/redux/app_state.dart';
import '../services/intl.dart' as intl;
import '../services/ws_api.dart' as ws_api;

class App extends StatelessWidget {

  final Store<AppState> store;

  App({
    this.store,
  }) {
    ws_api.init(store);
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: intl.appName,
    theme: ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.blueAccent,
    ),
    routes: routesFactory(store),
  );

}
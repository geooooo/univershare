import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../services/redux/app_state.dart';
import '../services/route.dart';
import '../services/intl.dart' as intl;

class App extends StatelessWidget {

  final Store<AppState> store;

  App({
    this.store,
  });

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
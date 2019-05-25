import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../services/route.dart';
import '../services/app_state.dart';

class App extends StatelessWidget {

  final Store<AppState> store;

  App({this.store});

  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
    store: store,
    child: MaterialApp(
      title: 'Univershare',
      theme: ThemeData.dark(),
      routes: routesFactory(store),
    ),
  );

}
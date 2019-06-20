import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../services/route.dart';
import '../services/connection_status.dart';
import '../services/redux/app_state.dart';
import '../services/redux/actions.dart' as actions;
import '../services/intl.dart' as intl;
import '../services/ws_api.dart' as ws_api;

class App extends StatefulWidget {

  final Store<AppState> store;

  App({
    this.store,
  });

  @override
  State<App> createState() => AppWidgetState(
    store: store,
  );

}

class AppWidgetState extends State<App> {

  final ConnectionStatus _connectionStatus = ConnectionStatus.getInstance();
  final Store<AppState> store;
  StreamSubscription _connectionChangeStream;

  AppWidgetState({
    this.store,
  });

  @override
  void initState() {
    super.initState();
    _connectionStatus.initialize();
    _connectionChangeStream = _connectionStatus.connectionChange.listen(_onConnectionChanged);
    ws_api.reconnectStream.listen((_) => ws_api.init(store));
  }

  @override
  void dispose() {
    _connectionChangeStream.cancel();
    _connectionStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    store.dispatch(actions.SetContext(context));
    return MaterialApp(
      title: intl.appName,
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blueAccent,
      ),
      routes: routesFactory(store),
    );
  }

  Future<void> _onConnectionChanged(bool isConnect) async {
    if (isConnect) {
     await ws_api.init(store);
     return;
    }
    await ws_api.disconnect();
  }

}
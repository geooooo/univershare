import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'src/services/redux/app_state.dart';
import 'src/services/redux/reducer.dart';
import 'src/widgets/app.dart';

void main() {
  final store = Store<AppState>(
    appReducers,
    initialState: AppState.initial(),
  );

  runApp(StoreProvider<AppState>(
    store: store,
    child: App(
      store: store,
    ),
  ));
}
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'src/widgets/app.dart';
import 'src/services/app_state.dart';
import 'src/services/reducer.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
  );

  runApp(App(
    store: store,
  ));
}
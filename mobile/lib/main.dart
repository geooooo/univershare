import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'src/widgets/app.dart';
import 'package:mobile/src/services/redux/app_state.dart';
import 'package:mobile/src/services/redux/reducer.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
  );

  runApp(App(
    store: store,
  ));
}
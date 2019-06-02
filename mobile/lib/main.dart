import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'src/widgets/app.dart';
import 'package:mobile/src/services/redux/app_state.dart';
import 'package:mobile/src/services/redux/reducer.dart';
import 'src/services/redux/middleware.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      restApiMiddleware,
    ],
  );

  runApp(App(
    store: store,
  ));
}
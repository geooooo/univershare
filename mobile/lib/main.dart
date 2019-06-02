import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'src/widgets/app.dart';
import 'src/services/app_state.dart';
import 'src/services/reducer.dart';
import 'src/services/epics.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
//    middleware: [
//      EpicMiddleware(restApiEpic),
//    ],
  );

  runApp(App(
    store: store,
  ));
}
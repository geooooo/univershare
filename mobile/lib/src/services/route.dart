import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../services/redux/app_state.dart';
import '../widgets/start_page/start_page.dart';
import '../widgets/create_event_page/create_event_page.dart';
import '../widgets/listener_page/listener_page.dart';
//import 'package:mobile/src/widgets/create_event_page/create_event_page.dart';
//import 'package:mobile/src/widgets/presenter_page/presenter_page.dart';
//import 'package:mobile/src/widgets/listener_page/listener_page.dart';

const String startPageRoute = '/';
const String createEventRoute = '/create_event';
const String presenterRoute = '/presenter';
const String listenerRoute = '/listener';

Map<String, WidgetBuilder> routesFactory(Store<AppState> store) => {
  startPageRoute: (BuildContext context) => ListenerPage(
    store: store,
  ),
  createEventRoute: (BuildContext context) => CreateEventPage(
    store: store,
  ),
  presenterRoute: (BuildContext context) => StartPage(
    store: store,
  ),
  listenerRoute: (BuildContext context) => StartPage(
    store: store,
  ),
};
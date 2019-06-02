import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:mobile/src/services/redux/app_state.dart';
import '../widgets/start_page.dart';
import '../widgets/create_event_page.dart';
import '../widgets/presenter_page.dart';
import '../widgets/listener_page.dart';

const String startPageRoute = '/';
const String createEventRoute = '/create_event';
const String presenterRoute = '/presenter';
const String listenerRoute = '/listener';

Map<String, WidgetBuilder> routesFactory(Store<AppState> store) => {
  startPageRoute: (BuildContext context) => StartPage(
    store: store,
  ),
//  startPageRoute: (BuildContext context) => CreateEventPage(
//    store: store,
//  ),
  createEventRoute: (BuildContext context) => CreateEventPage(
    store: store,
  ),
  presenterRoute: (BuildContext context) => PresenterPage(
    store: store,
  ),
  listenerRoute: (BuildContext context) => ListenerPage(
    store: store,
  ),
};
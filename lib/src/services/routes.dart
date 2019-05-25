import 'package:flutter/material.dart';

import '../widgets/start_page.dart';
import '../widgets/create_event_page.dart';
import '../widgets/presenter_page.dart';
import '../widgets/listener_page.dart';

const String startPageRoute = '/';
const String createEventRoute = '/create_event';
const String presenterRoute = '/presenter';
const String listenerRoute = '/listener';

final Map<String, WidgetBuilder> routes = {
  startPageRoute: (BuildContext context) => StartPage(),
  createEventRoute: (BuildContext context) => CreateEventPage(),
  presenterRoute: (BuildContext context) => PresenterPage(),
  listenerRoute: (BuildContext context) => ListenerPage(),
};

class ListenerRouteData {

  String userName;
  String eventId;

  ListenerRouteData({this.eventId, this.userName});

}
import 'package:flutter/material.dart';

import 'start_page.dart';
import 'create_event_page.dart';
import 'presenter_page.dart';
import 'listener_page.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (BuildContext context) => StartPage(),
  '/create_event': (BuildContext context) => CreateEventPage(),
  '/presenter': (BuildContext context) => PresenterPage(),
  '/listener': (BuildContext context) => ListenerPage(),
};

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Univershare',
    theme: ThemeData.dark(),
    routes: routes,
  );

}
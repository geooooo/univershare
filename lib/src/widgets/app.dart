import 'package:flutter/material.dart';

import '../services/routes.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Univershare',
    theme: ThemeData.dark(),
    routes: routes,
  );

}
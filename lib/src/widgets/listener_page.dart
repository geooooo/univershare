import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../services/app_state.dart';

class ListenerPage extends StatelessWidget {

  final Store<AppState> store;

  ListenerPage({this.store});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          tabs: <Widget>[
            Tab(
              child: Icon(Icons.settings),
            ),
            Tab(
              child: Icon(Icons.chat),
            ),
            Tab(
              child: Icon(Icons.visibility),
            )
          ],
        ),
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: TabBarView(
          children: [
            Text('1'),
            Text('1'),
            Text('1'),
          ],
        ),
      ),
    ),
  );

}


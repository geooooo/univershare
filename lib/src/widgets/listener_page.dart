import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../services/app_state.dart';
import 'listener_page_chat.dart';
import 'listener_page_control.dart';
import 'listener_page_presentation.dart';

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
            Tab(child: Icon(Icons.settings)),
            Tab(child: Icon(Icons.chat)),
            Tab(child: Icon(Icons.visibility)),
          ],
        ),
        body: TabBarView(
          children: [
            //TODO: temp
            ListenerPagePresentation(
              store: store,
            ),
            ListenerPageControl(
              store: store,
            ),
            ListenerPageChat(
              store: store,
            ),
          ],
        ),
      ),
    ),
  );

}


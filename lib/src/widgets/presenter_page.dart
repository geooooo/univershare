import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../services/app_state.dart';
import 'page_chat.dart';
import 'presenter_page_control.dart';
import 'presenter_page_questions.dart';

class PresenterPage extends StatelessWidget {

  final Store<AppState> store;

  PresenterPage({this.store});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          tabs: <Widget>[
            Tab(child: Icon(Icons.settings)),
            Tab(child: Icon(Icons.chat)),
            Tab(child: Icon(Icons.list)),
          ],
        ),
        body: TabBarView(
          children: [
            PresenterPageQuestions(
              store: store,
            ),
            PresenterPageControl(
              store: store,
            ),
            PageChat(
              store: store,
              isQuestionEnabled: false,
            ),

          ],
        ),
      ),
    ),
  );

}


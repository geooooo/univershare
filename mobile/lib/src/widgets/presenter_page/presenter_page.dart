import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../../services/redux/app_state.dart';
import '../common/page.dart';
import '../chat/chat.dart';
import 'presenter_page_control.dart';
import 'presenter_page_questions.dart';

class PresenterPage extends StatelessWidget {

  final Store<AppState> store;

  PresenterPage({
    this.store,
  });

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 3,
    child: Page(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      isScroll: false,
      appBar: TabBar(
        tabs: <Widget>[
          Tab(child: Icon(Icons.settings)),
          Tab(child: Icon(Icons.chat)),
          Tab(child: Icon(Icons.list)),
        ],
      ),
      child: TabBarView(
        children: [
          PresenterPageControl(
            store: store,
          ),
          Chat(
            store: store,
            isQuestionEnabled: false,
          ),
          PresenterPageQuestions(
            store: store,
          ),
        ],
      ),
    ),
  );

}
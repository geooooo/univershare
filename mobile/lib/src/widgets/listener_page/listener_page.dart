import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../services/redux/actions.dart' as actions;
import '../../services/redux/app_state.dart';
import '../common/page.dart';
import '../common/colored_tab_bar.dart';
import '../chat/chat.dart';
import 'listener_page_control.dart';
import 'listener_page_presentation.dart';

class ListenerPage extends StatelessWidget {

  final Store<AppState> store;

  ListenerPage({
    this.store,
  });

  @override
  Widget build(BuildContext context) {
    store.dispatch(actions.SetContext(context));

    return DefaultTabController(
      length: 3,
      child: Page(
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        isScroll: false,
        appBar: ColoredTabBar(
          color: Colors.black12,
          tabBar: TabBar(
            tabs: <Widget>[
              Tab(child: Icon(Icons.settings)),
              Tab(child: Icon(Icons.chat)),
              Tab(child: Icon(Icons.visibility)),
            ],
          )
        ),
        child: TabBarView(
          children: [
            ListenerPageControl(
              store: store,
            ),
            Chat(
              store: store,
              isQuestionEnabled: true,
            ),
            StoreConnector<AppState, String>(
              converter: (store) => store.state.presentationUrl,
              builder: (context, presentationUrl) => ListenerPagePresentation(
                presentationUrl: presentationUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }

}


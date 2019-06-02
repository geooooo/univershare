import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../services/redux/app_state.dart';
import 'start_page_content.dart';
import 'loading.dart';

class StartPage extends StatelessWidget {

  final Store<AppState> store;

  StartPage({
    this.store,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                  minWidth: viewportConstraints.maxWidth,
                ),
                child: StartPageContent(
                  store: store,
                ),
              ),
            ),
          ),
          StoreConnector<AppState, bool>(
            converter: (store) => store.state.startPageState.isLoadingShow,
            builder: (context, isShow) => isShow? Loading() : Container(),
          ),
        ],
      ),
    ),
  );

}


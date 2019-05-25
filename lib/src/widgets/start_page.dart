import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../services/app_state.dart';
import 'start_page_content.dart';

class StartPage extends StatelessWidget {

  final Store<AppState> store;

  StartPage({this.store});

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
    resizeToAvoidBottomPadding: false,
    body: SafeArea(
      child: LayoutBuilder(
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
    ),
  );

}


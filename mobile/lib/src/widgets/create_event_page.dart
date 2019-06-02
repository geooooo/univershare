import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:mobile/src/services/redux/app_state.dart';
import 'create_event_page_content.dart';

class CreateEventPage extends StatelessWidget {

  final Store<AppState> store;

  CreateEventPage({
    this.store,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
              minWidth: viewportConstraints.maxWidth,
            ),
            child: CreateEventPageContent(
              store: store,
            ),
          ),
        ),
      ),
    ),
  );

}
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../services/redux/app_state.dart';
import 'loading.dart';

class Page extends StatelessWidget {

  final Store<AppState> store;
  final Widget child;

  Page({
    this.store,
    this.child,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
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
              child: child,
            ),
          ),
        ),
        StoreConnector<AppState, bool>(
          converter: (store) => store.state.isLoadingVisible,
          builder: (context, isVisible) => Visibility(
            child: Loading(),
            visible: isVisible,
          ),
        ),
      ],
    ),
  );

}


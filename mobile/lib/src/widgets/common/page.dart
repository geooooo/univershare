import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../services/redux/app_state.dart';
import 'loading.dart';

class Page extends StatelessWidget {

  final Store<AppState> store;
  final Widget child;
  final PreferredSizeWidget appBar;
  final bool isScroll;
  final bool resizeToAvoidBottomInset;
  final bool resizeToAvoidBottomPadding;

  Page({
    this.store,
    this.child,
    this.appBar,
    this.isScroll,
    this.resizeToAvoidBottomInset = false,
    this.resizeToAvoidBottomPadding = false,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
      body: Stack(
        children: <Widget>[
          isScroll? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                  minWidth: viewportConstraints.maxWidth,
                ),
                child: child,
              ),
            ),
          ) : child,
          StoreConnector<AppState, bool>(
            converter: (store) => store.state.isLoadingVisible,
            builder: (context, isVisible) => Visibility(
              child: Loading(),
              visible: isVisible,
            ),
          ),
        ],
      ),
    ),
  );

}


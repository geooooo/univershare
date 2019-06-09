//import 'package:flutter/material.dart';
//import 'package:redux/redux.dart';
//import 'package:flutter_redux/flutter_redux.dart';
//
//import '../services/redux/app_state.dart';
//import 'package:mobile/src/widgets/create_event_page/create_event_page_content.dart';
//import 'loading.dart';
//
//class CreateEventPage extends StatelessWidget {
//
//  final Store<AppState> store;
//
//  CreateEventPage({
//    this.store,
//  });
//
//  @override
//  Widget build(BuildContext context) => SafeArea(
//    child: Scaffold(
//      resizeToAvoidBottomInset: false,
//      resizeToAvoidBottomPadding: false,
//      body: Stack(
//        children: <Widget>[
//          LayoutBuilder(
//            builder: (BuildContext context, BoxConstraints viewportConstraints) => SingleChildScrollView(
//              child: ConstrainedBox(
//                constraints: BoxConstraints(
//                  minHeight: viewportConstraints.maxHeight,
//                  minWidth: viewportConstraints.maxWidth,
//                ),
//                child: CreateEventPageContent(
//                  store: store,
//                ),
//              ),
//            ),
//          ),
//          StoreConnector<AppState, bool>(
//            converter: (store) => store.state.isLoadingShow,
//            builder: (context, isShow) => isShow? Loading() : Container(),
//          ),
//        ],
//      ),
//    ),
//  );
//
//}
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../services/app_state.dart';

class PresenterPage extends StatelessWidget {

  final Store<AppState> store;

  PresenterPage({this.store});

  @override
  Widget build(BuildContext context) => Container();

}
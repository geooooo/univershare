import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../services/intl.dart' as intl;
import '../services/asset.dart' as asset;
import '../services/redux/action.dart' as action;
import '../services/route.dart' as route;
import '../services/redux/app_state.dart';
import 'vertical_space.dart';
import 'event_id.dart';
import 'dialog_join.dart';

class StartPageContent extends StatelessWidget {

  static const double _logoSize = 150;

  final Store<AppState> store;

  StartPageContent({
    this.store,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      StoreConnector<AppState, bool>(
        converter: (store) => store.state.startPageState.isShowDialogJoin,
        builder: (context, isShowDialogJoin) => isShowDialogJoin? _showDialogJoin(context) : Container(),
      ),
      Image(
        image: AssetImage(asset.icon),
        height: _logoSize,
        width: _logoSize,
      ),
      VerticalSpace(30),
      StoreConnector<AppState, EventIdOnChangedFunction>(
        converter: (store) => (id, isValid) => store.dispatch(action.SetEventId(id, isValid)),
        builder: (context, callback) => EventId(
          onChanged: callback,
        ),
      ),
      VerticalSpace(20),
      StoreConnector<AppState, Map<String, Object>>(
        converter: (store) => <String, Object>{
          'isJoinButtonDisabled':  store.state.startPageState.isJoinButtonDisabled,
          'callback': () { print(store.state.eventId); return store.dispatch(action.ExistsEvent(store.state.eventId));},
        },
        builder: (context, data) {
          final callback = data['callback'] as Function;
          final isJoinButtonDisabled = data['isJoinButtonDisabled'] as bool;
          return RaisedButton(
            child: Text(intl.join),
            onPressed: callback,
          );
        },
      ),
      VerticalSpace(30),
      Text(intl.or),
      VerticalSpace(30),
      RaisedButton(
        child: Text(intl.createEvent),
        onPressed: () => _onPressedCreateButton(context),
      ),
    ],
  );

  void _onPressedCreateButton(BuildContext context) => Navigator.pushNamed(
    context,
    route.createEventRoute,
  );

  Widget _showDialogJoin(BuildContext context) => StoreConnector<AppState, DialogJoinOnPressedJoinFunction>(
    converter: (store) => (name) => store.dispatch(action.SetUserName(name)),
    builder: (context, callback) => DialogJoin(
      onPressedJoin: (name) {
        callback(name);
        Navigator.pushReplacementNamed(
          context,
          route.listenerRoute,
        );
      },
    ),
  );

}
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../services/intl.dart' as intl;
import '../services/asset.dart' as asset;
import '../services/redux/action.dart' as action;
import '../services/route.dart' as route;
import '../services/rest_api.dart' as rest_api;
import '../services/redux/app_state.dart';
import 'vertical_space.dart';
import 'event_id.dart';
import 'dialog_join.dart';
import 'dialog_error.dart';

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
      Image(
        image: AssetImage(asset.icon),
        height: _logoSize,
        width: _logoSize,
      ),
      VerticalSpace(30),
      StoreConnector<AppState, Function>(
        converter: (store) => (id, isValid) => store.dispatch(action.SetEventId(id, isValid)),
        builder: (context, callback) => EventId(
          onChanged: callback,
        ),
      ),
      VerticalSpace(20),
      StoreConnector<AppState, bool>(
        converter: (store) => store.state.startPageState.isJoinButtonDisabled,
        builder: (context, isJoinButtonDisabled) => RaisedButton(
          child: Text(intl.join),
          onPressed: isJoinButtonDisabled? null : () => _onJoinButtonPressed(context),
        ),
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

  void _onJoinButtonPressed(BuildContext context) async {
    store.dispatch(action.Loading(true));
    final response = await rest_api.existsEvent(store.state.eventId);
    store.dispatch(action.Loading(false));
    if (response.status == 0) {
      await _showDialogJoin(context);
    } else {
      await showDialogError(context, intl.eventNotExists);
    }
  }

  Future<Widget> _showDialogJoin(BuildContext context) async => await showDialog(
    context: context,
    builder: (BuildContext _) => DialogJoin(
      onPressedJoin: (userName) async {
        store.dispatch(action.Loading(true));
        store.dispatch(action.SetUserName(userName));
        final response = await rest_api.joinEvent(
          userName: store.state.userName,
          eventId: store.state.eventId,
        );
        store.dispatch(action.SetEventInfo(response.eventName, response.presentationUrl, response.userId));
        store.dispatch(action.Loading(false));
        await Navigator.pushNamed(
          context,
          route.listenerRoute,
        );
      },
    ),
  );

}
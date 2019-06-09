import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../services/assets.dart' as assets;
import '../../services/intl.dart' as intl;
import '../../services/route.dart' as route;
import '../../services/redux/app_state.dart';
import '../../services/redux/actions.dart' as actions;
import '../../services/rest_api.dart' as rest_api;
import '../common/page.dart';
import '../common/vertical_space.dart';
import '../common/dialog_info.dart';
import 'dialog_join.dart';
import 'event_id.dart';

class StartPage extends StatelessWidget {

  static const double _logoSize = 150;

  final Store<AppState> store;

  StartPage({
    this.store,
  });

  @override
  Widget build(BuildContext context) => Page(
    isScroll: true,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage(assets.icon),
          height: _logoSize,
          width: _logoSize,
        ),
        VerticalSpace(30),
        EventId(
          onChanged: _onChangedEventId,
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
    ),
  );

  void _onPressedCreateButton(BuildContext context) => Navigator.pushNamed(
    context,
    route.createEventRoute,
  );

  void _onChangedEventId(String eventId, bool isValid) {
    store.dispatch(actions.SetEventId(eventId, isValid));
  }

  void _onJoinButtonPressed(BuildContext context) async {
    store.dispatch(actions.Loading(true));
    final response = await rest_api.existsEvent(store.state.eventId);
    store.dispatch(actions.Loading(false));
    if (response.status == 0) {
      await showDialogJoin(
        context: context,
        store: store,
      );
    } else {
      await showDialogInfo(
        context: context,
        title: intl.error,
        message: intl.eventNotExistsError,
      );
    }
  }

}


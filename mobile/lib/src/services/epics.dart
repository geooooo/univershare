import 'package:redux_epics/redux_epics.dart';
import 'package:api_models/api_models.dart' as api_models;

import 'app_state.dart';
import 'action.dart';
import 'rest_api.dart' as rest_api;

final restApiEpic = combineEpics<AppState>([
  TypedEpic<AppState, ExistsEvent>(_existsEventEpic),
]);

Stream<Object> _existsEventEpic(Stream<ExistsEvent> actions, EpicStore<AppState> store) =>
  actions.asyncMap((action) => rest_api.existsEvent(action.eventId)
    .then((api_models.ExistsEventResponse response) => ExistsEventResult(response.status == 0))
    .catchError((_) => null));
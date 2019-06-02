import 'package:redux_epics/redux_epics.dart';
import 'package:api_models/api_models.dart' as api_models;

import '../rest_api.dart' as rest_api;
import 'action.dart';
import 'app_state.dart';

final restApiMiddleware = EpicMiddleware<AppState>(combineEpics<AppState>([
  TypedEpic<AppState, ExistsEvent>(existsEventEpic),
]));

Stream<Object> existsEventEpic(Stream<ExistsEvent> actions, EpicStore<AppState> store) =>
  actions.asyncMap((action) => rest_api.existsEvent(action.eventId)
    .then((api_models.ExistsEventResponse response) => ExistsEventResult((response.status == 0)? true : false))
    .catchError((_) => null));

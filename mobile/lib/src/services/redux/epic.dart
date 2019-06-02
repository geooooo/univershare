import 'package:redux_epics/redux_epics.dart';
import 'package:api_models/api_models.dart' as api_models;
import '../rest_api.dart';
import 'action.dart';
import 'app_state.dart';

Stream<Object> existsEventEpic(Stream<ExistsEvent> actions, EpicStore<AppState> store) =>
  actions.asyncMap((action) => existsEvent(action.eventId)
    .then((api_models.ExistsEventResponse response) => ExistsEventResult(response.status == 0))
    .catchError((_) => null));
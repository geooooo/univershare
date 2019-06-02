import 'package:redux_epics/redux_epics.dart';

import 'epic.dart';
import 'app_state.dart';
import 'action.dart';

final _restApiEpic = combineEpics<AppState>([
  TypedEpic<AppState, ExistsEvent>(existsEventEpic),
]);

final restApiMiddleware = EpicMiddleware(_restApiEpic);

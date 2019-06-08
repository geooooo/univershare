import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/controllers/controllers.dart';
import 'package:server/src/internal/di_injector.dart';

Router createRouter(DiInjector diInjector) => Router()
  ..route('/create_event').link(() => CreateEventController(diInjector))
  ..route('/exists_event').link(() => ExistsEventController(diInjector))
  ..route('/get_event_messages').link(() => GetEventMessagesController(diInjector))
  ..route('/get_new_event_id').link(() => GetNewEventIdController(diInjector))
  ..route('/join_event').link(() => JoinEventController(diInjector))
  ..route('/connect').link(() => WebSocketController(diInjector))
  ..route('/assets/presentations/*').link(() => AssetsController(diInjector));




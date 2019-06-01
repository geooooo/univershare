import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart';

import 'package:server/src/internal/di_injector.dart';

class ListenterEventExitController extends ResourceController {

  final DiInjector _diInjector;

  ListenterEventExitController(this._diInjector);

  @Operation.post()
  Future<Response> listenerEventExit(@Bind.body() ListenerEventExitRequest request) async {
    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, request.asMap());
//    await _diInjector.db.listenerEventExit(request.eventId, request.userId);
    final response = ListenerEventExitResponse();
    return Response.ok(response);
  }

}

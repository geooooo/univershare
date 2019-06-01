import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart';

import 'package:server/src/internal/di_injector.dart';

class ExistsEventController extends ResourceController {

  final DiInjector _diInjector;

  ExistsEventController(this._diInjector);

  @Operation.post()
  Future<Response> existsEvent(@Bind.body() ExistsEventRequest request) async {
    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, request.asMap());
    final data = await _diInjector.db.existsEvent(request.eventId);
    final response = ExistsEventResponse()
      ..status = data? 0 : 1;
    return Response.ok(response);
  }

}

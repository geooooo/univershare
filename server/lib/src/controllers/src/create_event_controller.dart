import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart';

import 'package:server/src/internal/di_injector.dart';

class CreateEventController extends ResourceController {

  final DiInjector _diInjector;

  CreateEventController(this._diInjector);

  @Operation.post()
  Future<Response> createEvent(@Bind.body() CreateEventRequest request) async {
    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, request.asMap());
//    final data = await _diInjector.db.selectSettings(request.login);
    final response = CreateEventResponse();
    return Response.ok(response);
  }

}

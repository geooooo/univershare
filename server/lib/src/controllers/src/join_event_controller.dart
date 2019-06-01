import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart';

import 'package:server/src/internal/di_injector.dart';

class JoinEventController extends ResourceController {

  final DiInjector _diInjector;

  JoinEventController(this._diInjector);

  @Operation.post()
  Future<Response> joinEvent(@Bind.body() JoinEventRequest request) async {
    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, request.asMap());
//    final data = await _diInjector.db.selectSettings(request.login);
    final response = JoinEventResponse()
//      ..readFromMap(data)TODO:
      ..status = 0;
    return Response.ok(response);
  }

}

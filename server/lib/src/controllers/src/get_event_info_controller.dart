import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart';

import 'package:server/src/internal/di_injector.dart';

class GetEventInfoController extends ResourceController {

  final DiInjector _diInjector;

  GetEventInfoController(this._diInjector);

  @Operation.post()
  Future<Response> getEventInfo(@Bind.body() GetEventInfoRequest request) async {
    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, request.asMap());
//    final data = await _diInjector.db.selectSettings(request.login);
    final response = GetEventInfoResponse()
//      ..readFromMap(data)TODO:
      ..status = 0;
    return Response.ok(response);
  }

}

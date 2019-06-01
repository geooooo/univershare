import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart';

import 'package:server/src/internal/di_injector.dart';

class PresenterEventExitController extends ResourceController {

  final DiInjector _diInjector;

  PresenterEventExitController(this._diInjector);

  @Operation.post()
  Future<Response> presenterEventExit(@Bind.body() PresenterEventExitRequest request) async {
    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, request.asMap());
//    final data = await _diInjector.db.selectSettings(request.login);
    final response = PresenterEventExitResponse();
    return Response.ok(response);
  }

}

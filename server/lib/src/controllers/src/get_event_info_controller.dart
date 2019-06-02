import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart' as api_models;

import 'package:server/src/internal/di_injector.dart';

class GetEventInfoController extends ResourceController {

  final DiInjector _diInjector;

  GetEventInfoController(this._diInjector);

  @Operation.post()
  Future<Response> getEventInfo(@Bind.body() Object request) async {
    final requestData = api_models.GetEventInfoRequest()..readFromMap(request);
    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, requestData.asMap());
    final responseData = await _diInjector.db.getEventInfo(requestData.eventId);
    final response = api_models.GetEventInfoResponse()
      ..readFromMap(responseData)
      ..status = 0;
    return Response.ok(response.asMap());
  }

}

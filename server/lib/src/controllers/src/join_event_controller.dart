import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart' as api_models;

import 'package:server/src/internal/di_injector.dart';

class JoinEventController extends ResourceController {

  final DiInjector _diInjector;

  JoinEventController(this._diInjector);

  @Operation.post()
  Future<Response> joinEvent(@Bind.body() Object request) async {
    final requestData = api_models.JoinEventRequest()..readFromMap(request);
    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, requestData.asMap());
    final responseData = await _diInjector.db.joinEvent(requestData.eventId, requestData.userName);
    final response = api_models.JoinEventResponse()
      ..readFromMap(responseData)
      ..status = 0;
    return Response.ok(response.asMap());
  }

}

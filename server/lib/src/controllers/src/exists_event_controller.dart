import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart' as api_models;

import 'package:server/src/internal/di_injector.dart';

class ExistsEventController extends ResourceController {

  final DiInjector _diInjector;

  ExistsEventController(this._diInjector);

  @Operation.post()
  Future<Response> existsEvent(@Bind.body() Object request) async {
    final requestData = api_models.ExistsEventRequest()..readFromMap(request);
    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, requestData.asMap());
    final responseData = await _diInjector.db.existsEvent(requestData.eventId);
    final response = api_models.ExistsEventResponse()
      ..status = responseData? 0 : 1;
    return Response.ok(response.asMap());
  }

}

import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart' as api_models;

import 'package:server/src/internal/di_injector.dart';

class GetEventMessagesController extends ResourceController {

  final DiInjector _diInjector;

  GetEventMessagesController(this._diInjector);

  @Operation.post()
  Future<Response> getEventMessages(@Bind.body() Object request) async {
    final requestData = api_models.GetEventMessagesRequest()..readFromMap(request);
    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, requestData.asMap());
    final responseData = await _diInjector.db.getEventMessages(requestData.eventId);
    final response = api_models.GetEventMessagesResponse()
      ..readFromMap(responseData)
      ..status = 0;
    return Response.ok(response.asMap());
  }

}

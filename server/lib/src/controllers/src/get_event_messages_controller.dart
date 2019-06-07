import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/di_injector.dart';
import 'package:api_models/api_models.dart' as api_models;

class GetEventMessagesController extends ResourceController {

  final DiInjector _diInjector;

  GetEventMessagesController(this._diInjector);

  @Operation.post()
  Future<Response> getEventMessages(@Bind.body() Object request) async {
    final requestData = api_models.GetEventMessagesRequest.fromMap(request);

    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, requestData.toJson());

    final responseData = await _diInjector.db.getEventMessages(requestData.eventId);
    final response = api_models.GetEventMessagesResponse.fromMap(responseData)
      ..status = 0;

    return Response.ok(response.toJson());
  }

}

import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart';

import 'package:server/src/internal/di_injector.dart';

class GetEventMessagesController extends ResourceController {

  final DiInjector _diInjector;

  GetEventMessagesController(this._diInjector);

  @Operation.post()
  Future<Response> getEventMessages(@Bind.body() GetEventMessagesRequest request) async {
    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, request.asMap());
    final data = await _diInjector.db.getEventMessages(request.eventId);
    final response = GetEventMessagesResponse()
      ..readFromMap(data)
      ..status = 0;
    return Response.ok(response);
  }

}

import 'dart:math' as math;

import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/di_injector.dart';
import 'package:api_models/api_models.dart' as api_models;
import 'package:server/src/internal/common.dart' as common;

class GetNewEventIdController extends ResourceController {

  final DiInjector _diInjector;

  GetNewEventIdController(this._diInjector);

  @Operation.post()
  Future<Response> getNewEventId(@Bind.body() Object request) async {
    final requestData = api_models.GetNewEventIdRequest.fromMap(request);

    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, requestData.toJson());

    final responseData = <String, Object> {
      'event_id': generateEventId(),
    };
    final response = api_models.GetNewEventIdResponse.fromMap(responseData)
      ..status = 0;

    return Response.ok(response.toJson());
  }

  String generateEventId() {
    final random = math.Random.secure();
    var eventId = '';

    for (var i = 0; i < common.eventIdLength; i++) {
      final number = random.nextInt(DateTime.now().millisecond) % 16;
      final char = number.toRadixString(16);
      eventId = '$eventId$char';
      final isAddSeparator = ((i + 1) % 3 == 0) && (i != (common.eventIdLength - 1));
      if (isAddSeparator) {
        eventId = '$eventId${common.eventIdSeparator}';
      }
    }

    return eventId;
  }

}

import 'dart:math' as math;

import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart';

import 'package:server/src/internal/di_injector.dart';

class GetNewEventIdController extends ResourceController {

  static const int eventIdLength = 9;
  static const String eventIdSeparator = '-';

  final DiInjector _diInjector;

  GetNewEventIdController(this._diInjector);

  @Operation.post()
  Future<Response> getNewEventId(@Bind.body() GetNewEventIdRequest request) async {
    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, request.asMap());
    final data = <String, Object> {
      'event_id': generateEventId(),
    };
    final response = GetNewEventIdResponse()
      ..readFromMap(data)
      ..status = 0;
    return Response.ok(response);
  }

  String generateEventId() {
    final random = math.Random.secure();
    var eventId = '';

    for (var i = 0; i < eventIdLength; i++) {
      final number = random.nextInt(DateTime.now().millisecond) % 16;
      final char = number.toRadixString(16);
      eventId = '$eventId$char';
      final isAddSeparator = ((i + 1) % 3 == 0) && (i != (eventIdLength - 1));
      if (isAddSeparator) {
        eventId = '$eventId$eventIdSeparator';
      }
    }

    return eventId;
  }

}

import 'dart:convert' as conv;

import 'package:http/http.dart' as http;
import 'package:api_models/api_models.dart' as api_models;

const String host = 'https://univershare.herokuapp.com/';

Future<api_models.ExistsEventResponse> existsEvent(String eventId) async {
  final responseData = conv.jsonDecode((await http.post(
    '${host}exists_event',
    body: conv.jsonEncode({
      'event_id': eventId,
    })
  )).body);
  return api_models.ExistsEventResponse()..readFromMap(responseData);
}

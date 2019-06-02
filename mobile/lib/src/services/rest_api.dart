import 'dart:convert' as conv;

import 'package:http/http.dart' as http;
import 'package:api_models/api_models.dart' as api_models;

const String host = 'https://univershare.herokuapp.com/';

Future<api_models.ExistsEventResponse> existsEvent(String eventId) async {
  final requestData = api_models.ExistsEventRequest()
    ..eventId = eventId;
  final responseDataRaw = (await http.post(
    '${host}exists_event',
    body: conv.jsonEncode(requestData.asMap()),
  )).body;
  final responseData = api_models.ExistsEventResponse()..readFromMap(conv.jsonDecode(responseDataRaw));
  print(responseData.asMap());
  return responseData;
}

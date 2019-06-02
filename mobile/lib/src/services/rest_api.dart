import 'dart:io' as io;
import 'dart:convert' as conv;

import 'package:http/http.dart' as http;
import 'package:api_models/api_models.dart' as api_models;

const String host = 'http://univershare.herokuapp.com/';

Future<api_models.ExistsEventResponse> existsEvent(String eventId) async {
  final requestData = api_models.ExistsEventRequest()
    ..eventId = eventId;
  final responseDataRaw = await _post('${host}exists_event', requestData.asMap());
  final responseData = api_models.ExistsEventResponse()..readFromMap(conv.jsonDecode(responseDataRaw));
  return responseData;
}

Future<String> _post(String url, Map<String, Object> data) async => (await http.post(
  url,
  body: conv.jsonEncode(data),
  encoding: conv.Utf8Codec(),
  headers: {
    io.HttpHeaders.contentTypeHeader: io.ContentType.json.toString(),
  },
)).body;
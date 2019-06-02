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

Future<api_models.GetNewEventIdResponse> getNewEventId() async {
  final requestData = api_models.GetNewEventIdRequest();
  final responseDataRaw = await _post('${host}get_new_event_id', requestData.asMap());
  final responseData = api_models.GetNewEventIdResponse()..readFromMap(conv.jsonDecode(responseDataRaw));
  return responseData;
}

Future<api_models.CreateEventResponse> createEvent({
  String eventId,
  String eventName,
  String userName,
  List<int> presentationFile,
}) async {
  final requestData = api_models.CreateEventRequest()
    ..eventName = eventName
    ..eventId = eventId
    ..userName = userName
    ..presentationFile = conv.base64Encode(presentationFile);
  final responseDataRaw = await _post('${host}create_event', requestData.asMap());
  final responseData = api_models.CreateEventResponse()..readFromMap(conv.jsonDecode(responseDataRaw));
  return responseData;
}

Future<api_models.JoinEventResponse> joinEvent({
  String eventId,
  String userName,
}) async {
  final requestData = api_models.JoinEventRequest()
    ..eventId = eventId
    ..userName = userName;
  final responseDataRaw = await _post('${host}join_event', requestData.asMap());
  final responseData = api_models.JoinEventResponse()..readFromMap(conv.jsonDecode(responseDataRaw));
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
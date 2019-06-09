import 'dart:io' as io;
import 'dart:convert' as conv;

import 'package:http/http.dart' as http;
import 'package:api_models/api_models.dart' as api_models;

import 'common.dart' as data;

Future<api_models.ExistsEventResponse> existsEvent(String eventId) async {
  final request = api_models.ExistsEventRequest(
    eventId: eventId,
  ).asMap();
  final response = await _post('${data.http_host}exists_event', request);
  return api_models.ExistsEventResponse.fromJson(response);
}

Future<api_models.GetNewEventIdResponse> getNewEventId() async {
  final request = api_models.GetNewEventIdRequest().asMap();
  final response = await _post('${data.http_host}get_new_event_id', request);
  return api_models.GetNewEventIdResponse.fromJson(response);
}

Future<api_models.CreateEventResponse> createEvent({
  String eventId,
  String eventName,
  String userName,
  List<int> presentationFile,
}) async {
  final request = api_models.CreateEventRequest(
    eventName: eventName,
    eventId: eventId,
    userName: userName,
    presentationFile: conv.base64Encode(presentationFile),
  ).asMap();
  print(presentationFile.length);
  print(request);
  final response = await _post('${data.http_host}create_event', request);
  return api_models.CreateEventResponse.fromJson(response);
}

Future<api_models.JoinEventResponse> joinEvent({
  String eventId,
  String userName,
}) async {
  final request = api_models.JoinEventRequest(
    eventId: eventId,
    userName: userName,
  ).asMap();
  final response = await _post('${data.http_host}join_event', request);
  return api_models.JoinEventResponse.fromJson(response);
}

Future<api_models.GetEventMessagesResponse> getEventMessages(String eventId) async {
  final request = api_models.GetEventMessagesRequest(
    eventId: eventId,
  ).asMap();
  final response = await _post('${data.http_host}get_event_messages', request);
  return api_models.GetEventMessagesResponse.fromJson(response);
}

Future<String> _post(String url, Map<String, Object> data) async => (await http.post(
  url,
  body: conv.jsonEncode(data),
  encoding: conv.Utf8Codec(),
  headers: {
    io.HttpHeaders.contentTypeHeader: io.ContentType.json.toString(),
  },
)).body;
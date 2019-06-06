import 'dart:io' as io;
import 'dart:convert' as conv;

import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart' as api_models;

import 'package:server/src/internal/di_injector.dart';
import 'package:server/src/internal/general.dart';

class WebSocketController extends Controller {

  final DiInjector _diInjector;

  WebSocketController(this._diInjector);

  @override
  Future<Response> handle(Request request) async {
    final connection = await io.WebSocketTransformer.upgrade(request.raw);
    _diInjector.logger.logWebSocketApiConnect();
    connection.listen((jsonData) => onDataListener(connection, jsonData), onDone: onDoneListener);
    return null;
  }

  Future<void> onDataListener(io.WebSocket connection, Object jsonData) async {
    print(General.connections.length);
    print(General.connections[General.connections.keys.first].length);
    final data = conv.json.decode(jsonData);
    final eventName = data['name'];
    final eventData = data['data'];

    _diInjector.logger.logWebSocketApi(eventName, eventData);

    switch (eventName) {
      case 'connect':
        onConnect(connection, eventData);
        break;
      case 'disconnect_presenter':
        await onDisconnectPresenter(connection, eventData);
        break;
      case 'disconnect_listener':
        onDisconnectListener(connection, eventData);
        break;
      case 'new_message':
        await onNewMessage(connection, eventData);
        break;
    }
  }

  void onDoneListener() =>
    _diInjector.logger.logWebSocketApiDisconnect();

  void onConnect(io.WebSocket connectionSender, Map<String, Object> eventData) {
    final data = api_models.WebSocketConnectData()..readFromMap(eventData);
    if (General.connections[data.eventId].isEmpty) {
      General.connections[data.eventId] = <int, io.WebSocket>{};
    }
    General.connections[data.eventId][data.userId] = connectionSender;
  }

  Future<void> onDisconnectPresenter(io.WebSocket connectionSender, Map<String, Object> eventData) async {
    final data = api_models.WebSocketDisconnectPresenterData()..readFromMap(eventData);
    General.connections.remove(data.eventId);

    General.connections[data.eventId].forEach((_, connection) {
      if (connection == connectionSender) {
        return;
      }
      final responseData = conv.jsonEncode((api_models.WebSocketEvent()
        ..name = 'event_end'
        ..data = api_models.WebSocketEventEndData()
      ).asMap());
      connection.add(responseData);
    });

    await _diInjector.db.removeEventData(data.eventId);
  }

  void onDisconnectListener(io.WebSocket connectionSender, Map<String, Object> eventData) {
    final data = api_models.WebSocketDisconnectListenerData()..readFromMap(eventData);
    General.connections[data.eventId].remove(data.userId);
  }

  Future<void> onNewMessage(io.WebSocket connectionSender, Map<String, Object> eventData) async {
    final data = api_models.WebSocketNewMessageData()..readFromMap(eventData);

    General.connections[data.eventId].forEach((_, connection) {
      if (connection == connectionSender) {
        return;
      }
      final responseData = conv.jsonEncode((api_models.WebSocketEvent()
        ..name = 'get_message'
        ..data = (api_models.WebSocketGetMessageData()
          ..text = data.text
          ..userName = data.userName
          ..isQuestion = data.isQuestion)
      ).asMap());
      connection.add(responseData);
    });

    await _diInjector.db.newMessage(data.userId, data.text, data.isQuestion);
  }

}

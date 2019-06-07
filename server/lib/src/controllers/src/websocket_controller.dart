import 'dart:io' as io;
import 'dart:convert' as conv;

import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/di_injector.dart';
import 'package:server/src/internal/common.dart' as common;
import 'package:api_models/api_models.dart' as api_models;

class WebSocketController extends Controller {

  final DiInjector _diInjector;

  WebSocketController(this._diInjector);

  @override
  Future<Response> handle(Request request) async {
    final socket = await io.WebSocketTransformer.upgrade(request.raw);
    _diInjector.logger.logWebSocketApiConnect();
    socket.listen((event) => onDataListener(socket, event), onDone: onDoneListener);
    return null;
  }

  Future<void> onDataListener(io.WebSocket socket, String event) async {
    final webSocketEvent = api_models.WebSocketEvent.fromJson(event);

    _diInjector.logger.logWebSocketApi(event);

    switch (webSocketEvent.name) {
      case 'connect':
        onConnect(event, socket);
        break;
//      case 'disconnect_presenter':
//        await onDisconnectPresenter(connection, eventData);
//        break;
//      case 'disconnect_listener':
//        onDisconnectListener(connection, eventData);
//        break;
//      case 'new_message':
//        await onNewMessage(connection, eventData);
//        break;
    }
  }
//
  void onDoneListener() =>
    _diInjector.logger.logWebSocketApiDisconnect();

  void onConnect(String event, io.WebSocket socket) {
    final data = api_models.WebSocketConnect.fromJson(event);
    if (!common.connections.containsKey(data.eventId)) {
      common.connections[data.eventId] = <int, io.WebSocket>{};
    }
    common.connections[data.eventId][data.userId] = socket;
  }
//
//  Future<void> onDisconnectPresenter(io.WebSocket connectionSender, Map<String, Object> eventData) async {
//    final data = api_models.WebSocketDisconnectPresenterData()..readFromMap(eventData);
//    General.connections.remove(data.eventId);
//
//    General.connections[data.eventId].forEach((_, connection) {
//      if (connection == connectionSender) {
//        return;
//      }
//      final responseData = conv.jsonEncode((api_models.WebSocketEvent()
//        ..name = 'event_end'
//        ..data = api_models.WebSocketEventEndData()
//      ).asMap());
//      connection.add(responseData);
//    });
//
//    await _diInjector.db.removeEventData(data.eventId);
//  }
//
//  void onDisconnectListener(io.WebSocket connectionSender, Map<String, Object> eventData) {
//    final data = api_models.WebSocketDisconnectListenerData()..readFromMap(eventData);
//    General.connections[data.eventId].remove(data.userId);
//  }
//
//  Future<void> onNewMessage(io.WebSocket connectionSender, Map<String, Object> eventData) async {
//    final data = api_models.WebSocketNewMessageData()..readFromMap(eventData);
//
//    General.connections[data.eventId].forEach((_, connection) {
//      if (connection == connectionSender) {
//        return;
//      }
//      final responseData = conv.jsonEncode((api_models.WebSocketEvent()
//        ..name = 'get_message'
//        ..data = (api_models.WebSocketGetMessageData()
//          ..text = data.text
//          ..userName = data.userName
//          ..isQuestion = data.isQuestion)
//      ).asMap());
//      connection.add(responseData);
//    });
//
//    await _diInjector.db.newMessage(data.userId, data.text, data.isQuestion);
//  }

}

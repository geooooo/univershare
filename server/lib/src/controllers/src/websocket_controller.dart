import 'dart:io' as io;
import 'dart:convert' as conv;

import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/di_injector.dart';
import 'package:server/src/internal/common.dart';
import 'package:api_models/api_models.dart' as api_models;

class WebSocketController extends Controller {

  final DiInjector _diInjector;

  Map<String, Map<int, io.WebSocket>> get connections => _diInjector.common.connections;

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
      case 'disconnect_presenter':
        await onDisconnectPresenter(event, socket);
        break;
      case 'disconnect_listener':
        onDisconnectListener(event, socket);
        break;
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
    if (!connections.containsKey(data.eventId)) {
      connections[data.eventId] = <int, io.WebSocket>{};
    }
    connections[data.eventId][data.userId] = socket;
  }

  Future<void> onDisconnectPresenter(String event, io.WebSocket socket) async {
    final data = api_models.WebSocketDisconnectPresenter.fromJson(event);
    connections.remove(data.eventId);

    await _diInjector.db.removeEvent(data.eventId);

    connections[data.eventId].forEach((_, connection) {
      if (connection == socket) {
        return;
      }
      final responseData = api_models.WebSocketEventEndData().toJson();
      connection.add(responseData);
    });
  }

  void onDisconnectListener(String event, io.WebSocket socket) {
    final data = api_models.WebSocketDisconnectListener.fromJson(event);
    connections[data.eventId].remove(data.userId);
  }
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

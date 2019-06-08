import 'dart:io' as io;

import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/di_injector.dart';
import 'package:api_models/api_models.dart' as api_models;

class WebSocketController extends Controller {

  final DiInjector _diInjector;

  Map<String, Map<int, io.WebSocket>> get connections => _diInjector.common.connections;

  WebSocketController(this._diInjector);

  @override
  Future<Response> handle(Request request) async {
    final socket = await io.WebSocketTransformer.upgrade(request.raw)
      ..pingInterval = _diInjector.common.pingInterval;
    
    _diInjector.logger.logWebSocketApiConnect();
    
    socket.listen((event) => onDataListener(socket, event), onDone: onDoneListener);
    return null;
  }

  Future<void> onDataListener(io.WebSocket socket, String event) async {
    print(event);
    final webSocketEvent = api_models.WebSocketEvent.fromJson(event);

    _diInjector.logger.logWebSocketApi(event);

    switch (webSocketEvent.name) {
      case 'connect_presenter':
        onConnectPresenter(event, socket);
        break;
      case 'connect_listener':
        onConnectListener(event, socket);
        break;
      case 'disconnect_presenter':
        await onDisconnectPresenter(event, socket);
        break;
      case 'disconnect_listener':
        await onDisconnectListener(event, socket);
        break;
      case 'new_message':
        await onNewMessage(event, socket);
        break;
    }

    print(connections.keys);
    connections.keys.forEach((k) => print(connections[k].keys));
  }

  void onDoneListener() =>
    _diInjector.logger.logWebSocketApiDisconnect();

  void onConnectPresenter(String event, io.WebSocket socket) {
    final data = api_models.WebSocketConnectPresenter.fromJson(event);
    connections[data.eventId] = <int, io.WebSocket>{
      data.userId: socket,
    };
  }

  void onConnectListener(String event, io.WebSocket socket) {
    final data = api_models.WebSocketConnectListener.fromJson(event);
    if (!connections.containsKey(data.eventId)) {
      socket.add(api_models.WebSocketRetry().toJson());
      return;
    }
    connections[data.eventId][data.userId] = socket;
  }

  Future<void> onDisconnectPresenter(String event, io.WebSocket socket) async {
    final data = api_models.WebSocketDisconnectPresenter.fromJson(event);

    connections[data.eventId].forEach((_, connection) {
      if (connection == socket) {
        return;
      }
      connection.add(api_models.WebSocketEventEndData().toJson());
    });

    for (var userId in connections[data.eventId].keys) {
      await connections[data.eventId][userId].close();
    }
    connections.remove(data.eventId);
    scheduleRemoveEvent(data.eventId);
    await _diInjector.db.endEvent(data.eventId);
  }

  Future<void> onDisconnectListener(String event, io.WebSocket socket) async {
    final data = api_models.WebSocketDisconnectListener.fromJson(event);
    if (connections.containsKey(data.eventId)) {
      await connections[data.eventId][data.userId].close();
      connections[data.eventId].remove(data.userId);
    }
  }

  Future<void> onNewMessage(String event, io.WebSocket socket) async {
    final data = api_models.WebSocketNewMessage.fromJson(event);

    connections[data.eventId].forEach((userId, connection) async {
      if (connection == socket) {
        return;
      }
      if (socket.readyState != io.WebSocket.open) {
        await connection.close();
        connections[data.eventId].remove(userId);
        return;
      }
      socket.add(api_models.WebSocketGetMessage(
        text: data.text,
        userName: data.userName,
        isQuestion: data.isQuestion).toJson()
      );
    });

    await _diInjector.db.newMessage(data.userId, data.text, data.isQuestion);
  }

  void scheduleRemoveEvent(String eventId) =>
    Future.delayed(_diInjector.common.removeEventDelay).then(
      (_) => _diInjector.db.removeEvent(eventId)
    );

  void scheduleCheckPresenters() =>
    Future.delayed(_diInjector.common.pingInterval).then((_) async {
      connections.forEach((eventId, connectionData) async {
        final socket = connectionData.values.first;
        final isClose = (socket.readyState == io.WebSocket.closed) ||
                        (socket.readyState == io.WebSocket.closing);
        if (isClose) {
          await onDisconnectPresenter(
            api_models.WebSocketDisconnectPresenter(
              eventId: eventId,
            ).toJson(), socket
          );
        }
      });
    });
}

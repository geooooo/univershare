import 'dart:io' as io;
import 'dart:convert' as conv;

import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart' as api_models;

import 'package:server/src/internal/di_injector.dart';

class WebSocketController extends Controller {

  final DiInjector _diInjector;
  final Map<String, Map<int, io.WebSocket>> connections = {};

  WebSocketController(this._diInjector);

  @override
  Future<Response> handle(Request request) async {
    final connection = await io.WebSocketTransformer.upgrade(request.raw);
    _diInjector.logger.logWebSocketApiConnect();
    connection.listen((jsonData) => onDataListener(connection, jsonData), onDone: onDoneListener);
    return null;
  }

//  @Operation.post()
//  Future<Response> handler() async {
//    print('+');
////    _diInjector.logger.logRestApi(this.request.method, this.request.path.string, request.asMap());
////    final data = await _diInjector.db.selectSettings(request.login);
////    final response = PresenterEventExitResponse();
////    return Response.ok(response);
//    final socket = await io.WebSocketTransformer.upgrade(request.raw);
//    print('+');
//    socket.listen(listener);
//    return null;
//  }

  Future<void> onDataListener(io.WebSocket connection, Object jsonData) async {
    final data = conv.jsonDecode(jsonData);
    final eventName = data['event'];
    final eventData = data['data'];

    _diInjector.logger.logWebSocketApi(eventName, eventData);

    if (connections[eventData['event_id']].isEmpty) {
      connections[eventData['event_id']] = <int, io.WebSocket>{};
    }
    connections[eventData['event_id']][eventData['user_id']] = connection;

    switch (eventName) {
      case 'new_message':
        await onNewMessage(connection, eventData);
        break;
    }
  }

  void onDoneListener() =>
    _diInjector.logger.logWebSocketApiDisconnect();

  Future<void> onNewMessage(io.WebSocket connectionSender, Map<String, Object> eventData) async {
    final data = api_models.WebSocketNewMessageData()..readFromMap(eventData);

    await _diInjector.db.newMessage(data.userId, data.text, data.isQuestion);

    connections[data.eventId].forEach((_, connection) {
      if (connection == connectionSender) {
        return;
      }
      connection.add(api_models.WebSocketGetMessageData()
          ..text = data.text
          ..userName = data.userName
          ..isQuestion = data.isQuestion
      );
    });
  }

}

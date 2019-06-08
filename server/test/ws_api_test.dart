@Timeout(const Duration(seconds: 5))

import 'dart:io' as io;
import 'dart:async' as asc;

import 'package:api_models/api_models.dart' as api_models;
import 'package:server/src/services/src/db/src/event_table.dart';
import 'package:server/src/services/src/db/src/listener_table.dart';
import 'package:server/src/services/src/db/src/message_table.dart';
import 'package:server/src/services/src/db/src/presentation_table.dart';
import 'package:server/src/services/src/db/src/presenter_table.dart';
import 'package:server/src/services/src/db/src/user_table.dart';
import 'package:test/test.dart';
import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/common.dart';
import 'package:server/src/app.dart';

import 'mock/app_mock.dart';

const Map<String, String> wsHeaders = {
  'connection': 'Upgrade',
  'origin': 'ws://localhost:8888',
  'sec-websocket-version': '13',
  'host': 'localhost:8888',
  'sec-websocket-key': 'a2plZGdneHZ3YWZucnBrdg==',
  'upgrade': 'websocket',
};

Application<App> app;

const timerDuration = Duration(milliseconds: 0);

Map<String, Map<int, io.WebSocket>> get connections =>
  app.channel.diInjector.common.connections;

Future<void> dropAllTables() async {
  final querySelectEvent = Query<EventTable>(app.channel.diInjector.db.managedContext)
    ..canModifyAllInstances = true;
  await querySelectEvent.delete();

  final querySelectUser = Query<UserTable>(app.channel.diInjector.db.managedContext)
    ..canModifyAllInstances = true;
  await querySelectUser.delete();

  final querySelectListener = Query<ListenerTable>(app.channel.diInjector.db.managedContext)
    ..canModifyAllInstances = true;
  await querySelectListener.delete();

  final querySelectPresenter = Query<PresenterTable>(app.channel.diInjector.db.managedContext)
    ..canModifyAllInstances = true;
  await querySelectPresenter.delete();

  final querySelectPresentation = Query<PresentationTable>(app.channel.diInjector.db.managedContext)
    ..canModifyAllInstances = true;
  await querySelectPresentation.delete();

  final querySelectMessage = Query<MessageTable>(app.channel.diInjector.db.managedContext)
    ..canModifyAllInstances = true;
  await querySelectMessage.delete();
}

void main() {

  setUp(() async {
    app = Application<AppMock>()..options.port = 8888;
    await app.startOnCurrentIsolate();
  });

  tearDown(() async {
    await dropAllTables();
    await app.stop();
  });

  connectTest();
//  disconnectListenerTest();
//  disconnectPresenterTest();
//  newMessageTest();
//  pingTest();
//  pongTest();
//  eventEndTest();
//  getMessageTest();

}

void connectTest() {
  test('ws /connect', () async {
    final socket1 = await io.WebSocket.connect(Common.ws_host);
    final socket2 = await io.WebSocket.connect(Common.ws_host);
    final socket3 = await io.WebSocket.connect(Common.ws_host);

    socket1.add(api_models.WebSocketConnect(
      eventId: '111-111-111',
      userId: 1,
    ).toJson());

    socket2.add(api_models.WebSocketConnect(
      eventId: '111-111-111',
      userId: 2,
    ).toJson());

    socket3.add(api_models.WebSocketConnect(
      eventId: '222-222-222',
      userId: 3,
    ).toJson());

    asc.Timer.periodic(timerDuration, expectAsync1((asc.Timer timer) async {
      timer.cancel();

      expect(connections.length, 2);
      expect(connections['111-111-111'].length, 2);
      expect(connections['222-222-222'].length, 1);
      expect(connections['111-111-111'].containsKey(1), isTrue);
      expect(connections['111-111-111'].containsKey(2), isTrue);
      expect(connections['111-111-111'].containsKey(3), isFalse);
      expect(connections['222-222-222'].containsKey(3), isTrue);

      await socket1.close();
      await socket2.close();
      await socket3.close();
    }));
  });
}

void disconnectListenerTest() {
//  test('ws /disconnect_listener', () async {
//    await server.run();
//
//    final socket1 = await io.WebSocket.connect(Common.ws_host);
//    final socket2 = await io.WebSocket.connect(Common.ws_host);
//
//    socket1.add(api_models.WebSocketConnect(
//      eventId: '111-111-111',
//      userId: 1,
//    ).toJson());
//
//    socket2.add(api_models.WebSocketConnect(
//      eventId: '111-111-111',
//      userId: 2,
//    ).toJson());
//
//    socket1.add(api_models.WebSocketDisconnectListener(
//      eventId: '111-111-111',
//      userId: 1,
//    ).toJson());
//
//    await socket1.close();
//
//    asc.Timer.periodic(timerDuration, (asc.Timer timer) async {
//      timer.cancel();
//
////      expect(Common.connections.length, 1);
////      expect(common.connections['111-111-111'].length, 1);
////      expect(common.connections['111-111-111'].containsKey(1), isFalse);
////      expect(common.connections['111-111-111'].containsKey(2), isTrue);
//
//      await socket2.close();
//    });
//  }, skip: '');
}

void disconnectPresenterTest() {
//  test('ws /disconnect_presenter', () async {
//    await server.run();
//
//    final socket1 = await io.WebSocket.connect(Common.ws_host);
//    final socket2 = await io.WebSocket.connect(Common.ws_host);
//    final socket3 = await io.WebSocket.connect(Common.ws_host);
//    final socket4 = await io.WebSocket.connect(Common.ws_host);
//
//    int receiverCount = 0;
//    final listenHandler = (Object data) {
//      final event = api_models.WebSocketEvent.fromJson(data);
//      if (event.name == 'event_end') {
//        receiverCount++;
//      }
//    };
//
//    socket1.listen(listenHandler);
//    socket2.listen(listenHandler);
//    socket3.listen(listenHandler);
//    socket4.listen(listenHandler);
//
//    socket1.add(api_models.WebSocketConnect(
//      eventId: '111-111-111',
//      userId: 1,
//    ).toJson());
//
//    socket2.add(api_models.WebSocketConnect(
//      eventId: '111-111-111',
//      userId: 2,
//    ).toJson());
//
//    socket3.add(api_models.WebSocketConnect(
//      eventId: '111-111-111',
//      userId: 3,
//    ).toJson());
//
//    socket4.add(api_models.WebSocketConnect(
//      eventId: '111-111-111',
//      userId: 4,
//    ).toJson());
//
//    socket4.add(api_models.WebSocketDisconnectListener(
//      eventId: '111-111-111',
//      userId: 4,
//    ).toJson());
//
//    await socket4.close();
//
//    socket1.add(api_models.WebSocketDisconnectPresenter(
//      eventId: '111-111-111',
//    ).toJson());
//
//    await socket1.close();
//
//    asc.Timer.periodic(timerDuration, (asc.Timer timer) async {
//      timer.cancel();
//
//      expect(Common.connections.length, 0);
//      expect(receiverCount, 1);
//      expect(1, 0);
//
//      await socket2.close();
//      await socket3.close();
//    });
//  }, skip: '');
}

void newMessageTest() {
  test('ws /new_message', () async {
  }, skip: '');
}

void pingTest() {
  test('ws /ping', () async {
  }, skip: '');
}

void pongTest() {
  test('ws /pong', () async {
  }, skip: '');
}

void eventEndTest() {
  test('ws /event_end', () async {
  }, skip: '');
}

void getMessageTest() {
  test('ws /get_message', () async {
  }, skip: '');
}
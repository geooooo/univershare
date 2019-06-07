import 'dart:io' as io;
import 'dart:async' as asc;

import 'package:api_models/api_models.dart' as api_models;
import 'package:server/src/services/src/db/src/user_table.dart';
import 'package:test/test.dart';
import 'package:aqueduct_test/aqueduct_test.dart';
import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/common.dart' as common;
import 'package:server/server.dart' as server;

import 'harness/app.dart';

AppHarness harness;

const Map<String, String> wsHeaders = {
  'connection': 'Upgrade',
  'origin': 'ws://localhost:8888',
  'sec-websocket-version': '13',
  'host': 'localhost:8888',
  'sec-websocket-key': 'a2plZGdneHZ3YWZucnBrdg==',
  'upgrade': 'websocket',
};

const timerDuration = Duration(milliseconds: 100);

void main() {

  harness = AppHarness()
    ..install(restartForEachTest: false);

  connectTest();
  disconnectListenerTest();
  disconnectPresenterTest();
  newMessageTest();
  pingTest();
  pongTest();
  eventEndTest();
  getMessageTest();

}

void connectTest() {
  test('ws /connect', () async {
    await server.run();

    final socket1 = await io.WebSocket.connect(common.ws_host);
    final socket2 = await io.WebSocket.connect(common.ws_host);
    final socket3 = await io.WebSocket.connect(common.ws_host);

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

    asc.Timer.periodic(timerDuration, (asc.Timer timer) async {
      timer.cancel();

      expect(common.connections.length, 2);
      expect(common.connections['111-111-111'].length, 2);
      expect(common.connections['222-222-222'].length, 1);
      expect(common.connections['111-111-111'].containsKey(1), isTrue);
      expect(common.connections['111-111-111'].containsKey(2), isTrue);
      expect(common.connections['111-111-111'].containsKey(3), isFalse);
      expect(common.connections['222-222-222'].containsKey(3), isTrue);

      await socket1.close();
      await socket2.close();
      await socket3.close();
    });
  });
}

void disconnectListenerTest() {
  test('ws /disconnect_listener', () async {
  }, skip: '');
}

void disconnectPresenterTest() {
  test('ws /disconnect_presenter', () async {
  }, skip: '');
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
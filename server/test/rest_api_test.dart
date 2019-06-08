import 'package:server/src/services/src/db/src/user_table.dart';
import 'package:test/test.dart';
import 'package:aqueduct_test/aqueduct_test.dart';
import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart' as api_models;
import 'package:server/src/internal/common.dart';

import 'harness/app.dart';

AppHarness harness;

void main() {

  harness = AppHarness()
    ..install(restartForEachTest: false);

  createEventTest();
  existsEventTest();
  getNewEventIdTest();
  joinEventTest();
  getEventMessagesTest();

}

void createEventTest() {
  test('POST /create_event', () async {
    final request = api_models.CreateEventRequest(
      eventName: 'eventName',
      presentationFile: 'aGVsbG8=',
      userName: 'newName',
      eventId: 'fff-fff-fff',
    );
    final response = await harness.agent.post(
      '/create_event',
      body: request.asMap(),
    );

    expectResponse(
      response,
      200,
      body: api_models.CreateEventResponse(status: 0).asMap(),
    );
  });
}

void existsEventTest() {
  test('POST /exists_event', () async {
    final request1 = api_models.ExistsEventRequest(
      eventId: '111-111-111',
    );
    final response1 = await harness.agent.post(
      '/exists_event',
      body: request1.asMap(),
    );

    expectResponse(
      response1,
      200,
      body: api_models.ExistsEventResponse(status: 0).asMap(),
    );

    final request2 = api_models.ExistsEventRequest(
      eventId: '222-222-222',
    );
    final response2 = await harness.agent.post(
      '/exists_event',
      body: request2.asMap(),
    );

    expectResponse(
      response2,
      200,
      body: api_models.ExistsEventResponse(status: 1).asMap(),
    );
  });
}

void getNewEventIdTest() {
  test('POST /get_new_event_id', () async {
    final request = api_models.GetNewEventIdRequest();
    final response = await harness.agent.post(
      '/get_new_event_id',
      body: request.asMap(),
    );

    expect(response.statusCode, 200);

    final data = response.body.as<Map<String, Object>>();
    final newEventId = data['event_id'] as String;
    final pattern = RegExp(r'^[0-9a-f]{3,}\-[0-9a-f]{3,}\-[0-9a-f]{3,}$', caseSensitive: false);
    expect(newEventId.startsWith(pattern), isTrue);
  });
}

void joinEventTest() {
  test('POST /join_event', () async {
    final userName = 'newName';
    final request = api_models.JoinEventRequest(
      eventId: '111-111-111',
      userName: userName,
    );
    final response = await harness.agent.post(
      '/join_event',
      body: request.asMap(),
    );

    final querySelectUser = Query<UserTable>(harness.context);
    final users = await querySelectUser.fetch();
    final newUserId = users.length;

    expectResponse(
      response,
      200,
      body: api_models.JoinEventResponse(
        status: 0,
        eventName: 'name1',
        presentationUrl: Common.getFullUrl('url1'),
        userId: newUserId,
      ).asMap(),
    );
  });
}

void getEventMessagesTest() {
  test('POST /get_event_messages', () async {
    final request = api_models.GetEventMessagesRequest(
      eventId: '111-111-111',
    );
    final response = await harness.agent.post(
      '/get_event_messages',
      body: request.asMap(),
    );

    expectResponse(
      response,
      200,
      body: api_models.GetEventMessagesResponse(
        status: 0,
        messages: <api_models.Message>[
          api_models.Message(
            userName: 'name1',
            text: 'text1',
            isQuestion: false,
          ),
          api_models.Message(
            userName: 'name2',
            text: 'text2',
            isQuestion: false,
          ),
          api_models.Message(
            userName: 'name3',
            text: 'text3',
            isQuestion: false,
          ),
        ],
      ).asMap(),
    );
  });
}
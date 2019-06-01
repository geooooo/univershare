import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/app_config.dart';

import 'src/managed_context.dart';
import 'src/event_table.dart';
import 'src/presentation_table.dart';
import 'src/user_table.dart';
import 'src/message_table.dart';

class Db {

  final ManagedContext managedContext;

  Db(AppConfig appConfig): managedContext = createManagedContext(appConfig);

  Future<void> createEvent(
      String eventId,
      String eventName,
      String creatorName,
      String presentationUrl,
  ) async {
    final queryCreateUser = Query<UserTable>(managedContext)
      ..values.name = creatorName;
    final newUser = await queryCreateUser.insert();

    final queryCreatePresentation = Query<PresentationTable>(managedContext)
      ..values.url = presentationUrl;
    final newPresentation = await queryCreatePresentation.insert();

    final queryCreateEvent = Query<EventTable>(managedContext)
      ..values.name = eventName
      ..values.id_code = eventId
      ..values.presentation = newPresentation
      ..values.presenter = newUser;
    await queryCreateEvent.insert();
  }

  Future<bool> existsEvent(String eventId) async {
    final querySelectEvent = Query<EventTable>(managedContext)
        ..where((EventTable event) => event.id_code).equalTo(eventId);
    final event = await querySelectEvent.fetchOne();
    return event != null;
  }

  Future<Map<String, Object>> getEventInfo(String eventId) async {
    final querySelectEvent = Query<EventTable>(managedContext)
      ..where((EventTable event) => event.id_code).equalTo(eventId);
    final event = await querySelectEvent.fetchOne();
    final presentationId = event.presentation.id;

    final querySelectPresentation = Query<PresentationTable>(managedContext)
      ..where((PresentationTable presentation) => presentation.id).equalTo(presentationId);
    final presentation = await querySelectPresentation.fetchOne();

    return <String, Object>{
      'event_name': event.name,
      'presentation_url': presentation.url,
    };
  }

  Future<Map<String, Object>> joinEvent(String eventId, String userName) async {
    final querySelectEvent = Query<EventTable>(managedContext)
      ..where((EventTable event) => event.id_code).equalTo(eventId);
    final event = await querySelectEvent.fetchOne();

    final queryCreateUser = Query<UserTable>(managedContext)
      ..values.name = userName
      ..values.event = event;
    final newUser = await queryCreateUser.insert();

    return <String, Object>{
      'user_id': newUser.id,
    };
  }

  Future<void> newMessage(int userId, String text, bool isQuestion) async {
    final queryCreateMessage = Query<MessageTable>(managedContext)
      ..values.text = text
      ..values.is_question = isQuestion
      ..values.user.id = userId;
    await queryCreateMessage.insert();
  }

  Future<void> removeEventData(String eventIdCode) async {
    final querySelectEvent = Query<EventTable>(managedContext)
      ..where((EventTable event) => event.id_code).equalTo(eventIdCode);
    final event = await querySelectEvent.fetchOne();
    final eventId = event.id;
    final presentation = event.presentation;
    final presenter = event.presenter;
    await querySelectEvent.delete();

    final querySelectPresenter = Query<UserTable>(managedContext)
      ..where((UserTable user) => user.id).equalTo(presenter.id);
    await querySelectPresenter.delete();

    final querySelectPresentation = Query<PresentationTable>(managedContext)
      ..where((PresentationTable presentation) => presentation.id).equalTo(presentation.id);
    await querySelectPresentation.delete();

    final querySelectListeners = Query<UserTable>(managedContext)
      ..where((UserTable user) => user.event.id).equalTo(eventId);
    await querySelectListeners.delete();
  }

}

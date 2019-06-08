import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/app_config.dart';

import 'src/managed_context.dart';
import 'src/event_table.dart';
import 'src/presentation_table.dart';
import 'src/user_table.dart';
import 'src/message_table.dart';
import 'src/presenter_table.dart';
import 'src/listener_table.dart';

class Db {

  final ManagedContext managedContext;

  Db(AppConfig appConfig): managedContext = createManagedContext(appConfig);

  Future<void> createEvent(
      String eventId,
      String eventName,
      String presenterName,
      String presentationUrl,
  ) async {
    final queryCreateUser = Query<UserTable>(managedContext)
      ..values.name = presenterName;
    final newUser = await queryCreateUser.insert();

    final queryCreatePresenter = Query<PresenterTable>(managedContext)
      ..values.user = newUser;
    final newPresenter = await queryCreatePresenter.insert();

    final queryCreatePresentation = Query<PresentationTable>(managedContext)
      ..values.url = presentationUrl;
    final newPresentation = await queryCreatePresentation.insert();

    final queryCreateEvent = Query<EventTable>(managedContext)
      ..values.name = eventName
      ..values.id_code = eventId
      ..values.presentation = newPresentation
      ..values.presenter = newPresenter
      ..values.is_active = true;
    await queryCreateEvent.insert();
  }

  Future<bool> existsEvent(String eventId) async {
    final querySelectEvent = Query<EventTable>(managedContext)
      ..where((EventTable event) => event.id_code).equalTo(eventId)
      ..where((EventTable event) => event.is_active).equalTo(true);
    final event = await querySelectEvent.fetchOne();
    return event != null;
  }

  Future<Map<String, Object>> getEventInfo(String eventId) async {
    final querySelectEvent = Query<EventTable>(managedContext)
      ..where((EventTable event) => event.id_code).equalTo(eventId);
    final event = await querySelectEvent.fetchOne();

    final querySelectPresentation = Query<PresentationTable>(managedContext)
      ..where((PresentationTable presentation) => presentation.id).equalTo(event.presentation.id);
    final presentation = await querySelectPresentation.fetchOne();

    return <String, Object>{
      'event_name': event.name,
      'presentation_url': presentation.url,
    };
  }

  Future<Map<String, Object>> joinEvent(String eventId, String listenerName) async {
    final querySelectEvent = Query<EventTable>(managedContext)
      ..where((EventTable event) => event.id_code).equalTo(eventId);
    final newEvent = await querySelectEvent.fetchOne();

    final queryCreateUser = Query<UserTable>(managedContext)
      ..values.name = listenerName;
    final newUser = await queryCreateUser.insert();

    final queryCreateListener = Query<ListenerTable>(managedContext)
      ..values.user = newUser
      ..values.event = newEvent;
    await queryCreateListener.insert();

    final querySelectPresentation = Query<PresentationTable>(managedContext)
      ..where((PresentationTable presentation) => presentation.id).equalTo(newEvent.presentation.id);
    final presentation = await querySelectPresentation.fetchOne();

    return <String, Object>{
      'user_id': newUser.id,
      'event_name': newEvent.name,
      'presentation_url': presentation.url,
    };
  }

  Future<void> newMessage(int userId, String text, bool isQuestion) async {
    final queryCreateMessage = Query<MessageTable>(managedContext)
      ..values.text = text
      ..values.is_question = isQuestion
      ..values.user.id = userId
      ..values.time = DateTime.now().millisecondsSinceEpoch;
    await queryCreateMessage.insert();
  }

  Future<void> endEvent(String eventIdCode) async {
    final querySelectEvent = Query<EventTable>(managedContext)
      ..where((EventTable event) => event.id_code).equalTo(eventIdCode)
      ..values.is_active = false;
    await querySelectEvent.updateOne();
  }

  Future<void> removeEvent(String eventIdCode) async {
    final querySelectEvent = Query<EventTable>(managedContext)
      ..where((EventTable event) => event.id_code).equalTo(eventIdCode);
    final delEvent = await querySelectEvent.fetchOne();
    await querySelectEvent.delete();

    final querySelectPresentation = Query<PresentationTable>(managedContext)
      ..where((PresentationTable presentation) => presentation.id).equalTo(delEvent.presentation.id);
    await querySelectPresentation.delete();

    final querySelectPresenter = Query<PresenterTable>(managedContext)
      ..where((PresenterTable presenter) => presenter.id).equalTo(delEvent.presenter.id);
    final delPresenter = await querySelectPresenter.fetchOne();
    await querySelectPresenter.delete();

    final querySelectListener = Query<ListenerTable>(managedContext)
      ..where((ListenerTable listener) => listener.event.id).equalTo(delEvent.id);
    final delListener = await querySelectListener.fetch();
    await querySelectListener.delete();

    final userIds = delListener.map((listener) => listener.user.id).toList()
      ..add(delPresenter.user.id);
    final querySelectUser = Query<UserTable>(managedContext)
      ..where((UserTable user) => user.id).oneOf(userIds);
    await querySelectUser.delete();

    final querySelectMessage = Query<MessageTable>(managedContext)
      ..where((MessageTable message) => message.user.id).oneOf(userIds);
    await querySelectMessage.delete();
  }

  Future<Map<String, Object>> getEventMessages(String eventIdCode) async {
    final querySelectEvent = Query<EventTable>(managedContext)
      ..where((EventTable event) => event.id_code).equalTo(eventIdCode);
    final event = await querySelectEvent.fetchOne();

    final querySelectListener = Query<ListenerTable>(managedContext)
      ..where((ListenerTable listener) => listener.event.id).equalTo(event.id);
    final listeners = await querySelectListener.fetch();

    final querySelectPresenter = Query<PresenterTable>(managedContext)
      ..where((PresenterTable presenter) => presenter.id).equalTo(event.presenter.id);
    final presenter = await querySelectPresenter.fetchOne();

    final userIds = listeners.map((listener) => listener.user.id).toList()
      ..add(presenter.user.id);

    final querySelectUser = Query<UserTable>(managedContext)
      ..where((UserTable user) => user.id).oneOf(userIds);
    final users = await querySelectUser.fetch();

    var messages = <Map<String, Object>>[];
    for (var user in users) {
      final querySelectMessage = Query<MessageTable>(managedContext)
        ..where((MessageTable message) => message.user.id).equalTo(user.id);
      final userMessages = await querySelectMessage.fetch();
      messages.addAll(userMessages.map((message) => <String, Object>{
        'user_name': user.name,
        'text': message.text,
        'is_question': message.is_question,
      }));
    }

    return <String, Object>{
      'messages': messages,
    };
  }

}

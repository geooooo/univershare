import 'package:aqueduct/aqueduct.dart';
import 'package:aqueduct_test/aqueduct_test.dart';
import 'package:server/src/app.dart';
import 'package:server/src/internal/app_config.dart';
import 'package:server/src/services/services.dart';
import 'package:server/src/services/src/db/src/event_table.dart';
import 'package:server/src/services/src/db/src/listener_table.dart';
import 'package:server/src/services/src/db/src/message_table.dart';
import 'package:server/src/services/src/db/src/presentation_table.dart';
import 'package:server/src/services/src/db/src/presenter_table.dart';
import 'package:server/src/services/src/db/src/user_table.dart';

class AppHarness extends TestHarness<App> with TestHarnessORMMixin {

  EventTable event1;
  PresenterTable presenter1;
  ListenerTable listener1;
  ListenerTable listener2;
  PresentationTable presentation1;
  MessageTable message1;
  MessageTable message2;
  MessageTable message3;
  UserTable user1;
  UserTable user2;
  UserTable user3;

  @override
  ManagedContext get context => channel.diInjector.db.managedContext;

  @override
  Future<void> onSetUp() async {
    channel.appConfig = AppConfig.test();
    channel.diInjector.db = Db(channel.appConfig);
    channel.diInjector.logger.isTestingMode = true;
    await resetData();
  }

  @override
  Future<void> seed() async {
    await _fillPresentationTable();
    await _fillUserTable();

    await _fillMessageTable();
    await _fillPresenterTable();
    await _fillEventTable();
    await _fillListenerTable();
  }

  Future<void> _fillEventTable() async {
    event1 = await (Query<EventTable>(context)
      ..values.name = 'name1'
      ..values.id_code = '111-111-111'
      ..values.presentation = presentation1
      ..values.presenter = presenter1
    ).insert();
  }

  Future<void> _fillPresenterTable() async {
    presenter1 = await (Query<PresenterTable>(context)
      ..values.user = user1
    ).insert();
  }

  Future<void> _fillPresentationTable() async {
    presentation1 = await (Query<PresentationTable>(context)
      ..values.url = 'url1'
    ).insert();
  }

  Future<void> _fillMessageTable() async {
    message1 = await (Query<MessageTable>(context)
      ..values.user = user1
      ..values.text = 'text1'
      ..values.is_question = false
      ..values.time = DateTime.now().millisecondsSinceEpoch
    ).insert();
    message2 = await (Query<MessageTable>(context)
      ..values.user = user2
      ..values.text = 'text2'
      ..values.is_question = false
      ..values.time = DateTime.now().millisecondsSinceEpoch
    ).insert();
    message3 = await (Query<MessageTable>(context)
      ..values.user = user3
      ..values.text = 'text3'
      ..values.is_question = false
      ..values.time = DateTime.now().millisecondsSinceEpoch
    ).insert();
  }

  Future<void> _fillListenerTable() async {
    listener1 = await (Query<ListenerTable>(context)
      ..values.user = user2
      ..values.event = event1
    ).insert();
    listener2 = await (Query<ListenerTable>(context)
      ..values.user = user3
      ..values.event = event1
    ).insert();
  }

  Future<void> _fillUserTable() async {
    user1 = await (Query<UserTable>(context)
      ..values.name = 'name1'
    ).insert();
    user2 = await (Query<UserTable>(context)
      ..values.name = 'name2'
    ).insert();
    user3 = await (Query<UserTable>(context)
      ..values.name = 'name3'
    ).insert();
  }

}
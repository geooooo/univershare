import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/app_config.dart';

import 'event_table.dart';
import 'user_table.dart';
import 'message_table.dart';
import 'presentation_table.dart';
import 'presenter_table.dart';
import 'listener_table.dart';

ManagedContext createManagedContext(AppConfig appConfig) => ManagedContext(
  ManagedDataModel([
    EventTable,
    UserTable,
    MessageTable,
    PresentationTable,
    PresenterTable,
    ListenerTable,
  ]),
  PostgreSQLPersistentStore.fromConnectionInfo(
    appConfig.database.username,
    appConfig.database.password,
    appConfig.database.host,
    appConfig.database.port,
    appConfig.database.databaseName,
  ),
);
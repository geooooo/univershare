import 'package:aqueduct/aqueduct.dart';

import 'user_table.dart';
import 'event_table.dart';

class ListenerTable extends ManagedObject<_ListenerTable> implements _ListenerTable {}

class _ListenerTable {

  @Column(
    primaryKey: true,
    autoincrement: true,
  )
  int id;

  @Relate(#listenerUser)
  UserTable user;

  @Relate(#listenerEvent)
  EventTable event;

}

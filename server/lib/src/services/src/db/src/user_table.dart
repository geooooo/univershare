import 'package:aqueduct/aqueduct.dart';

import 'event_table.dart';
import 'message_table.dart';

class UserTable extends ManagedObject<_UserTable> implements _UserTable {}

class _UserTable {

  @Column(
    primaryKey: true,
    autoincrement: true,
  )
  int id;

  @Column(
    nullable: false,
    unique: false,
  )
  String name;

  EventTable event;
  ManagedSet<MessageTable> message;

}

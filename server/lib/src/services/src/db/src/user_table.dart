import 'package:aqueduct/aqueduct.dart';

import 'presenter_table.dart';
import 'listener_table.dart';
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

  ManagedSet<MessageTable> messageUser;
  ListenerTable listenerUser;
  PresenterTable presenterUser;

}

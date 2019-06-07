import 'package:aqueduct/aqueduct.dart';

import 'user_table.dart';

class MessageTable extends ManagedObject<_MessageTable> implements _MessageTable {}

class _MessageTable {

  @Column(
    primaryKey: true,
    autoincrement: true,
  )
  int id;

  @Column(
    nullable: false,
    unique: false,
  )
  String text;

  @Column(
    nullable: false,
    unique: false,
  )
  bool is_question;

  @Column(
    nullable: false,
    unique: false,
  )
  int time;

  @Relate(#messageUser)
  UserTable user;

}

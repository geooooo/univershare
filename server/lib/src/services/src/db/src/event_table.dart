import 'package:aqueduct/aqueduct.dart';

import 'presentation_table.dart';
import 'user_table.dart';

class EventTable extends ManagedObject<_EventTable> implements _EventTable {}

class _EventTable {

  @Column(
    primaryKey: true,
    autoincrement: true,
  )
  int id;

  @Column(
    nullable: false,
    unique: true,
  )
  String id_code;

  @Column(
    nullable: false,
    unique: false,
  )
  String name;

  @Relate(#event)
  PresentationTable presentation;

  @Relate(#eventPresenter)
  UserTable presenter;

  ManagedSet<UserTable> userListener;

}

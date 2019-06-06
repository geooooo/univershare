import 'package:aqueduct/aqueduct.dart';

import 'user_table.dart';
import 'event_table.dart';

class PresenterTable extends ManagedObject<_PresenterTable> implements _PresenterTable {}

class _PresenterTable {

  @Column(
    primaryKey: true,
    autoincrement: true,
  )
  int id;

  @Relate(#presenterUser)
  UserTable user;

  EventTable eventPresenter;

}

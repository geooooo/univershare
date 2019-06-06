import 'package:aqueduct/aqueduct.dart';

import 'presentation_table.dart';
import 'listener_table.dart';
import 'presenter_table.dart';

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

  @Relate(#eventPresentation)
  PresentationTable presentation;

  @Relate(#eventPresenter)
  PresenterTable presenter;

  ManagedSet<ListenerTable> listenerEvent;

}

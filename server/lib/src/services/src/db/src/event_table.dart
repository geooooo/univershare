import 'package:aqueduct/aqueduct.dart';

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
  String idCode;

  @Column(
    nullable: false,
    unique: false,
  )
  String name;

//  foreign key(presentation_id) references presentation(id)
//  foreign key(presenter_id) references user(id)

}

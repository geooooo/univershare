import 'package:aqueduct/aqueduct.dart';

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

//  foreign key(user_id) references user(id)

}

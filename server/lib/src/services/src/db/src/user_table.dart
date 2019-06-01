import 'package:aqueduct/aqueduct.dart';

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

}

import 'package:aqueduct/aqueduct.dart';

class PresentationTable extends ManagedObject<_PresentationTable> implements _PresentationTable {}

class _PresentationTable {

  @Column(
    primaryKey: true,
    autoincrement: true,
  )
  int id;

  @Column(
    nullable: false,
    unique: false,
  )
  String url;

}
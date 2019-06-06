import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("_EventTable", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("id_code", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: true),SchemaColumn("name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_PresentationTable", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("url", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_UserTable", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_MessageTable", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("text", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("is_question", ManagedPropertyType.boolean, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("time", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_ListenerTable", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false)]));
		database.createTable(SchemaTable("_PresenterTable", [SchemaColumn("id", ManagedPropertyType.integer, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false)]));
		database.addColumn("_EventTable", SchemaColumn.relationship("presentation", ManagedPropertyType.integer, relatedTableName: "_PresentationTable", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: true));
		database.addColumn("_EventTable", SchemaColumn.relationship("presenter", ManagedPropertyType.integer, relatedTableName: "_PresenterTable", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: true));
		database.addColumn("_MessageTable", SchemaColumn.relationship("user", ManagedPropertyType.integer, relatedTableName: "_UserTable", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
		database.addColumn("_ListenerTable", SchemaColumn.relationship("user", ManagedPropertyType.integer, relatedTableName: "_UserTable", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: true));
		database.addColumn("_ListenerTable", SchemaColumn.relationship("event", ManagedPropertyType.integer, relatedTableName: "_EventTable", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
		database.addColumn("_PresenterTable", SchemaColumn.relationship("user", ManagedPropertyType.integer, relatedTableName: "_UserTable", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: true));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    
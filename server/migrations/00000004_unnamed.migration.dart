import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration4 extends Migration { 
  @override
  Future upgrade() async {
   		database.addColumn("_UserTable", SchemaColumn.relationship("event", ManagedPropertyType.integer, relatedTableName: "_EventTable", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: true));
		database.deleteColumn("_UserTable", "listener");
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    
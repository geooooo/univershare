
import 'package:aqueduct/aqueduct.dart' hide Response;

import 'package:api_models/src/response.dart';

class ExistsTeamRequest extends Serializable {

  String title;

  @override
  Map<String, dynamic> asMap() => {
      'title': title,
  };

  @override
  void readFromMap(Map<String, dynamic> inputMap) {
    title = inputMap['title'];
  }

}

// status:
//    0 - команда существует
//    1 - не существует
class ExistsTeamResponse extends Response {}

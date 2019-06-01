import 'package:aqueduct/aqueduct.dart';

class Response extends Serializable {

  int status = 0;

  @override
  Map<String, Object> asMap() => {
      'status': status,
  };

  @override
  void readFromMap(Map<String, Object> inputMap) {
    status = inputMap['status'];
  }

}

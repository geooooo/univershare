import 'package:aqueduct/aqueduct.dart';

class Response extends Serializable {

  int status = 0;

  @override
  Map<String, dynamic> asMap() => {
      'status': status,
  };

  @override
  void readFromMap(Map<String, dynamic> inputMap) {
    status = inputMap['status'];
  }

}

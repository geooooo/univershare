import 'serializable.dart';

abstract class Response extends Serializable {

  int status = 0;

  @override
  Map<String, Object> asMap() => {
    'status': status,
  };

  @override
  void readFromMap(Map<String, Object> data) {
    status = data['status'];
  }

}
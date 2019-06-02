abstract class Response {

  int status = 0;

  Map<String, Object> asMap() => {
      'status': status,
  };

  void readFromMap(Map<String, Object> inputMap) {
    status = inputMap['status'];
  }

}

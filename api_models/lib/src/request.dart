abstract class Request {

  Map<String, Object> asMap();

  void readFromMap(Map<String, Object> inputMap);

}

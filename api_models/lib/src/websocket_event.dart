import 'websocket_data.dart';
import 'request.dart';

class WebSocketEvent extends Request {

  String name;
  WebSocketData data;

  @override
  Map<String, Object> asMap() => {
    'name': name,
    'data': data.asMap(),
  };

  @override
  void readFromMap(Map<String, Object> inputMap) {
    name = inputMap['name'];
    data.readFromMap(inputMap['data']);
  }

}
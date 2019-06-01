import 'package:aqueduct/aqueduct.dart' show Serializable;

import 'websocket_data.dart';

class WebSocketEvent extends Serializable {

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
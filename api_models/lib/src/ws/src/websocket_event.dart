import '../../serializable.dart';

class WebSocketEvent extends Serializable {

  String name = '';

  @override
  WebSocketEvent();

  @override
  WebSocketEvent.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  WebSocketEvent.fromJson(String data): super.fromJson(data);

  @override
  Map<String, Object> asMap() => {
    'name': name,
  };

  @override
  void readFromMap(Map<String, Object> mapData) {
    name = mapData['name'];
  }

}
import 'websocket_data.dart';

class WebSocketPing extends WebSocketData {

  @override
  WebSocketPing();

  @override
  WebSocketPing.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  Map<String, Object> asMap() => {};

  @override
  void readFromMap(Map<String, Object> data) {}

}
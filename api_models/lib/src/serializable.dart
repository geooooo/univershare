import 'dart:convert' as conv;

abstract class Serializable {

  Serializable();

  Serializable.fromMap(Map<String, Object> data) {
    readFromMap(data);
  }

  Serializable.fromJson(String data) {
    final mapData = conv.jsonDecode(data);
    readFromMap(mapData);
  }

  Map<String, Object> asMap();

  void readFromMap(Map<String, Object> data);

  String toJson() => conv.jsonEncode(asMap());

}

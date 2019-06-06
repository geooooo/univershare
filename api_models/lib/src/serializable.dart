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

  String toJson() => conv.jsonEncode(toString());

  Map<String, Object> asMap();

  void readFromMap(Map<String, Object> data);

  @override
  String toString() => asMap().toString();

}

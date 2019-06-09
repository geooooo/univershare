import '../../serializable.dart';

abstract class Response extends Serializable {

  int status = 0;

  @override
  Response({
    this.status,
  });

  @override
  Response.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  Response.fromJson(String data): super.fromJson(data);

  @override
  Map<String, Object> asMap() => {
    'status': status,
  };

  @override
  void readFromMap(Map<String, Object> data) {
    status = data['status'];
  }

}
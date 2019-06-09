import '../../serializable.dart';

abstract class Request extends Serializable {

  @override
  Request();

  @override
  Request.fromMap(Map<String, Object> data): super.fromMap(data);

  @override
  Request.fromJson(String data): super.fromJson(data);

}

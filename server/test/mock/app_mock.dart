import 'package:server/src/app.dart';
import 'package:server/src/internal/app_config.dart';

class AppMock extends App {

  @override
  AppConfig appConfig = AppConfig.test();

}
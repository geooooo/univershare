import 'package:aqueduct/aqueduct.dart';

import 'internal/di_injector.dart';
import 'internal/router.dart';
import 'internal/app_logger.dart';
import 'internal/app_config.dart';
import 'services/services.dart';

class DartelloApp extends ApplicationChannel {

  AppConfig appConfig = AppConfig.local();
  DiInjector diInjector;

  @override
  Future<void> prepare() async {
    diInjector = DiInjector(
      logger: AppLogger(logger),
      db: Db(appConfig),
    );
  }

  @override
  Controller get entryPoint => createRouter(diInjector);

}

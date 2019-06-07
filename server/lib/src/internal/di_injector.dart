import 'package:server/src/services/services.dart';

import 'app_logger.dart';

class DiInjector {

  final AppLogger logger;
  Db db;

  DiInjector({
    this.logger,
    this.db,
  });

}
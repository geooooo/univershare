import 'package:server/src/internal/common.dart';
import 'package:server/src/services/services.dart';

import 'app_logger.dart';

class DiInjector {

  final AppLogger logger;
  Db db;
  final Common common;

  DiInjector({
    this.logger,
    this.db,
    this.common,
  });

}
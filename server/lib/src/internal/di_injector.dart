import 'package:server/src/services/services.dart';
import 'app_logger.dart';
import 'general.dart';

class DiInjector {

  final AppLogger logger;
  Db db;
  General general;

  DiInjector({this.logger, this.db, this.general});

}
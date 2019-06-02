import 'dart:io' as io;

import 'package:aqueduct/aqueduct.dart';

class AppConfig extends Configuration {

  static const String productionConfigPath = 'config.heroku.yaml';
  static const String localConfigPath = 'config.dev.yaml';

  DatabaseConfiguration database;

  AppConfig([String configPath = localConfigPath]): super.fromFile(io.File(configPath)) {
    if (configPath == productionConfigPath) {
      Controller.includeErrorDetailsInServerErrorResponses = true;
    }
  }

}
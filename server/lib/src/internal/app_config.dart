import 'dart:io' as io;

import 'package:aqueduct/aqueduct.dart';

class AppConfig extends Configuration {

  static const String _productionConfigPath = 'config.heroku.yaml';
  static const String _localConfigPath = 'config.dev.yaml';
  static const String _testConfigPath = 'config.test.yaml';

  DatabaseConfiguration database;

  AppConfig.production(): super.fromFile(io.File(_productionConfigPath)) {
    Controller.includeErrorDetailsInServerErrorResponses = true;
  }

  AppConfig.local(): super.fromFile(io.File(_localConfigPath));

  AppConfig.test(): super.fromFile(io.File(_testConfigPath));

}
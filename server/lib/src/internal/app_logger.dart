import 'package:aqueduct/aqueduct.dart';
import 'package:ansicolor/ansicolor.dart';

class AppLogger {

  static final methodColor = AnsiPen();
  static final uriColor = AnsiPen();
  static final bodyColor = AnsiPen();
  static final Logger _logger = Logger('main');

  bool isTestingMode;

  AppLogger(Logger aqueductLogger, {this.isTestingMode = false}) {
    hierarchicalLoggingEnabled = true;

    aqueductLogger.onRecord.listen((record) {
      if (record.error != null) {
        print('${record.error} ${record.stackTrace}');
      }
    });

    _logger
      ..level = Level.INFO
      ..onRecord.listen((LogRecord record) => print(record.message));

    methodColor
      ..xterm(33, bg: true)
      ..xterm(232, bg: false);

    uriColor
      ..xterm(35, bg: false);

    bodyColor
      ..xterm(15, bg: false);
  }

  void logRestApi(String method, String uri, Map<String, Object> body) {
    if (isTestingMode) {
      return;
    }
    _logger.info(
      '${methodColor(method.toUpperCase())} ${uriColor(uri)}\n'
      '${bodyColor(body.toString())}'
    );
  }

}
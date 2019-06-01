import 'package:aqueduct/aqueduct.dart';
import 'package:ansicolor/ansicolor.dart';

class AppLogger {

  static final methodColor = AnsiPen();
  static final uriColor = AnsiPen();
  static final bodyColor = AnsiPen();
  static final wsConnect = AnsiPen();
  static final wsDisconnect = AnsiPen();
  static final wsEventName = AnsiPen();
  static final Logger _logger = Logger('main');

  AppLogger(Logger aqueductLogger) {
    hierarchicalLoggingEnabled = true;

    aqueductLogger.onRecord.listen((record) {
      if (record.error != null) {
        print('${record.error} ${record.stackTrace}');
      }
    });

    _logger
      ..level = Level.INFO
      ..onRecord.listen((LogRecord record) => print(record.message));

    wsConnect
      ..xterm(14, bg: false);

    wsDisconnect
      ..xterm(13, bg: false);

    wsEventName
      ..xterm(10, bg: false);

    methodColor
      ..xterm(33, bg: true)
      ..xterm(232, bg: false);

    uriColor
      ..xterm(35, bg: false);

    bodyColor
      ..xterm(15, bg: false);
  }

  void logRestApi(String method, String uri, Map<String, Object> body) => _logger.info(
    '${methodColor(method.toUpperCase())} ${uriColor(uri)}\n'
    '${bodyColor(body.toString())}'
  );

  void logWebSocketApi(String eventName, Map<String, Object> eventData) => _logger.info(
    '${wsEventName(eventName)}\n'
    '${bodyColor(eventData.toString())}'
  );

  void logWebSocketApiConnect() => _logger.info(
    '${wsConnect('+ ws client')}'
  );

  void logWebSocketApiDisconnect() =>_logger.info(
    '${wsDisconnect('- ws client')}'
  );

}
import 'dart:io' as io;

class Common {

  static const String presentationExtension = '.pdf';
  static final String presentationDirPath = 'asset${io.Platform.pathSeparator}presentation';
  static const int eventIdLength = 9;
  static const String eventIdSeparator = '-';
  static const String http_host = 'http://localhost:8888';
  static const String ws_host = 'ws://localhost:8888/connect';

  final Map<String, Map<int, io.WebSocket>> connections = {};

  static String getFullUrl(String path) =>
      '${http_host}${io.Platform.pathSeparator}$path';

}
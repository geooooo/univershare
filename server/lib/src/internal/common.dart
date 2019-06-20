import 'dart:io' as io;

class Common {

  final String presentationExtension = '.pdf';
  final String presentationDirPath = 'assets${io.Platform.pathSeparator}presentations';
//  final String presentationDirPath = 'assets${io.Platform.pathSeparator}presentations';
  final int eventIdLength = 9;
  final String eventIdSeparator = '-';
  final String http_host = 'http://localhost:8888';
  final String ws_host = 'ws://localhost:8888/connect';
  final Map<String, Map<int, io.WebSocket>> connections = {};
  final Duration pingInterval = Duration(seconds: 5);
  final Duration removeEventDelay = Duration(seconds: 5);

  String getFullUrl(String path) =>
    '${http_host}${io.Platform.pathSeparator}$path';

}
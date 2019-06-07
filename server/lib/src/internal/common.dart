import 'dart:io' as io;

const String presentationExtension = '.pdf';
final String presentationDirPath = 'asset${io.Platform.pathSeparator}presentation';
const int eventIdLength = 9;
const String eventIdSeparator = '-';
const String http_host = 'http://localhost:8888';
const String ws_host = 'ws://localhost:8888/connect';

final Map<String, Map<int, io.WebSocket>> connections = {};

String getFullUrl(String path) =>
  '${http_host}${io.Platform.pathSeparator}$path';
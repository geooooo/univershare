import 'dart:io' as io;

const String presentationExtension = '.pdf';
final String presentationDirPath = 'asset${io.Platform.pathSeparator}presentation';
const int eventIdLength = 9;
const String eventIdSeparator = '-';
const String host = 'http://localhost:8888';
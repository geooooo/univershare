import 'dart:io' show Platform;

Duration apiTimeout = Duration(seconds: 3);
Duration apiTimeoutLong = Duration(seconds: 60);

// For production
//const String http_host = 'http://univershare.herokuapp.com/';
//const String ws_host = 'ws://univershare.herokuapp.com/connect';

// For local dev
final String http_host = (Platform.isAndroid)? 'http://10.0.2.2:8888/' : 'http://localhost:8888/';
final String ws_host = (Platform.isAndroid)? 'ws://10.0.2.2:8888/connect' : 'ws://localhost:8888/connect';

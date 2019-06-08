import 'dart:io' show Platform;

//const String http_host = 'http://univershare.herokuapp.com/';
//const String ws_host = 'ws://univershare.herokuapp.com/connect';

//const String http_host = 'http://10.0.2.2:8888/';
final String http_host = (Platform.isAndroid)? 'http://10.0.2.2:8888/' : 'http://localhost:8888/';
final String ws_host = (Platform.isAndroid)? 'ws://10.0.2.2:8888/connect' : 'ws://localhost:8888/connect';
import 'dart:io';
import 'dart:async';

import 'package:connectivity/connectivity.dart';

class ConnectionStatus {

  static final ConnectionStatus _singleton = new ConnectionStatus._internal();
  final Connectivity _connectivity = Connectivity();
  StreamController<bool> connectionChangeController = new StreamController.broadcast();
  bool hasConnection = false;

  Stream<bool> get connectionChange => connectionChangeController.stream;

  ConnectionStatus._internal();

  static ConnectionStatus getInstance() => _singleton;

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  void dispose() {
    connectionChangeController.close();
  }

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch(_) {
      hasConnection = false;
    }
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }
    return hasConnection;
  }

}
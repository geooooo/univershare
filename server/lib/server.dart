import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

import 'src/app.dart';

Future<void> run({int port = 8888, int isolatesCount = 2}) async {
  var app = new Application<DartelloApp>()
    ..options.port = port;

  print(
    'Server run !\n'
    'Port: $port\n'
    'Isolates count: $isolatesCount\n'
  );
  await app.start(numberOfInstances: isolatesCount);
}
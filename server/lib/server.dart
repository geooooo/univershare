import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

import 'src/app.dart';

Future<void> run({int port = 8888, int isolatesCount = 1}) async {
  final app = Application<App>()
    ..options.port = port;

  print(
    'Server run !\n'
    'Port: $port\n'
    'Isolates count: $isolatesCount\n'
  );
  await app.start(numberOfInstances: isolatesCount);
}
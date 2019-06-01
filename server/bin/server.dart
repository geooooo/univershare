import 'dart:io';

import 'package:server/server.dart';

Future<void> main() async => await run(
  port: int.parse(Platform.environment['PORT']),
  isolatesCount: 1,
);
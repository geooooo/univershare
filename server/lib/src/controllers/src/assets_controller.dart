import 'dart:io' as io;

import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/di_injector.dart';

class AssetsController extends FileController {

  AssetsController(DiInjector diInjector):
    super('${diInjector.common.presentationDirPath}${io.Platform.pathSeparator}');

}

import 'dart:io' as io;
import 'dart:convert' as conv;

import 'package:aqueduct/aqueduct.dart';
import 'package:api_models/api_models.dart';

import 'package:server/src/internal/di_injector.dart';

class CreateEventController extends ResourceController {

  static const int printFileByteCount = 16;
  static const String presentationExtension = '.pdf';
  static final String presentationDirPath = 'asset${io.Platform.pathSeparator}presentation';

  final DiInjector _diInjector;

  CreateEventController(this._diInjector);

  @Operation.post()
  Future<Response> createEvent(@Bind.body() CreateEventRequest request) async {
    final fileName = await movePresentationFile(request.presentationFile);
    final fileLogData = '[$fileName]: "${request.presentationFile.substring(0, printFileByteCount)}"';
    _diInjector.logger.logRestApi(
      this.request.method,
      this.request.path.string, 
      (request..presentationFile = fileLogData).asMap(),
    );
    await _diInjector.db.createEvent(
      request.eventId,
      request.eventName,
      request.userName,
      fileName,
    );
    final response = CreateEventResponse();
    return Response.ok(response);
  }
  
  Future<String>movePresentationFile(String fileData) async {
    final rawFileData = conv.base64Decode(fileData);
    final filePath = '$presentationDirPath${io.Platform.pathSeparator}${generateFileName()}$presentationExtension';
    final file = io.File(filePath);
    await file.writeAsBytes(rawFileData, flush: true);
    return filePath;
  }

  String generateFileName() {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final data = DateTime.now().toString();
    return '${data}_$time';
  }

}

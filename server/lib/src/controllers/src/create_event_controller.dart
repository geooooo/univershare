import 'dart:io' as io;
import 'dart:convert' as conv;

import 'package:api_models/api_models.dart' as api_models;
import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/di_injector.dart';

class CreateEventController extends ResourceController {

  final DiInjector _diInjector;

  CreateEventController(this._diInjector);

  @Operation.post()
  Future<Response> createEvent(@Bind.body() Object request) async {
    final requestData = api_models.CreateEventRequest.fromMap(request);
    final fileName = await movePresentationFile(requestData.presentationFile);

    final fileLogData = '[$fileName]';
    _diInjector.logger.logRestApi(
      this.request.method,
      this.request.path.string,
      (requestData..presentationFile = fileLogData).asMap(),
    );

    await _diInjector.db.createEvent(
      requestData.eventId,
      requestData.eventName,
      requestData.userName,
      fileName,
    );
    final response = api_models.CreateEventResponse(status: 0);

    return Response.ok(response.asMap());
  }
  
  Future<String>movePresentationFile(String fileData) async {
    final rawFileData = conv.base64Decode(fileData);
    await io.Directory.fromUri(Uri.file(_diInjector.common.presentationDirPath)).create(recursive: true);
    final filePath = '${_diInjector.common.presentationDirPath}'
                     '${io.Platform.pathSeparator}${generateFileName()}'
                     '${_diInjector.common.presentationExtension}';
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

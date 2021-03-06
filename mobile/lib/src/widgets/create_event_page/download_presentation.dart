import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

import '../../services/intl.dart' as intl;

typedef DownloadPresentationOnSelectFileFunction(String path);

class DownloadPresentation extends StatefulWidget {

  final DownloadPresentationOnSelectFileFunction onSelectFile;

  DownloadPresentation({
    this.onSelectFile,
  });

  @override
  State<DownloadPresentation> createState() => DownloadPresentationState(
    onSelectFile: onSelectFile,
  );

}

class DownloadPresentationState extends State<DownloadPresentation> {

  final DownloadPresentationOnSelectFileFunction onSelectFile;
  final TextEditingController _controller = TextEditingController();

  DownloadPresentationState({
    this.onSelectFile,
  });

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(
      horizontal: 50,
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(alignLabelWithHint: true,
              labelText: intl.selectFile,
            ),
            enabled: false,
          ),
        ),
        IconButton(
          icon: Icon(Icons.attach_file),
          onPressed: _onPressedSelectFile,
        )
      ],
    ),
  );

  Future<void>_onPressedSelectFile() async {
    final path = await FlutterDocumentPicker.openDocument(
      params: FlutterDocumentPickerParams(
        allowedUtiTypes: ['com.adobe.pdf '],
        allowedFileExtensions: ['pdf'],
        allowedMimeTypes: ['application/pdf'],
      ),
    );
    if ((path == null) || path.isEmpty) {
      return;
    }
    setState(() {
      _controller.text = path.split('/').last;
    });
    onSelectFile(path);
  }

}
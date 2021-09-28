// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

typedef void ViewCreatedCallback();

class FileType {
  static String get PDF => "PDF";
  static String get DOC => "DOC";
  static String get DOCX => "DOCX";
  static String get PPT => "PPT";
  static String get XLSX => "XLSX";
  static String get CSV => "CSV";
}

class FileViewer extends StatefulWidget {
  const FileViewer({
    Key? key,
    required this.filePath,
    required this.fileType,
    required this.isLocalFile,
    required this.onViewCreated,
  }) : super(key: key);

  @override
  _FileViewerState createState() => _FileViewerState();

  final String filePath;
  final String fileType;
  final bool isLocalFile;
  final VoidCallback onViewCreated;
}

class _FileViewerState extends State<FileViewer> {
  final Map<String, dynamic> creationParams = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    creationParams["url"] = widget.filePath;
    creationParams["fileType"] = widget.fileType;
    creationParams["isLocalFile"] = widget.isLocalFile;

    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(viewType: "NativeView", onPlatformViewCreated: _onPlatformViewCreated);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: "NativeView",
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the Flutter_File_Viewer plugin');
  }

  void _onPlatformViewCreated(int id) {
    print("id is " + id.toString());
    // final PDFViewController controller = PDFViewController(id, widget);
    // _controller.complete(controller);
    widget.onViewCreated();
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_file_viewer/file_viewer.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(const MaterialApp(
    title: 'Your title',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String rando = "what";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.

    try {
      // platformVersion =
      //     await FlutterFileViewer.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // rando = FileViewer.text1;
      // _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FileViewScreen(
                              filePath: "ios/Assets/TestPDF.pdf", fileType: FileType.PDF, isLocalFile: true, completedCallback: _onViewCreated),
                        ),
                      );
                    },
                    child: const Text("PDF file")),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FileViewScreen(
                              filePath: "https://drive.google.com/file/d/1fOr7PCibBCj7lvWCohUsAitfaLUkE1Uc/view?usp=sharing",
                              fileType: FileType.PDF,
                              isLocalFile: false,
                              completedCallback: _onViewCreated),
                        ),
                      );
                    },
                    child: const Text("PDF url")),
                TextButton(onPressed: () {}, child: const Text("Doc file")),
                TextButton(onPressed: () {}, child: const Text("Doc url")),
                TextButton(onPressed: () {}, child: const Text("PPT file")),
                TextButton(onPressed: () {}, child: const Text("PPT url")),
                TextButton(onPressed: () {}, child: const Text("Spreadsheet file")),
                TextButton(onPressed: () {}, child: const Text("Spreadsheet url")),
              ],
            ),
          )),
    );
  }

  void _onViewCreated() {
    //called
  }
}

class FileViewScreen extends StatefulWidget {
  final String filePath;
  final String fileType;
  final bool isLocalFile;
  final VoidCallback completedCallback;

  const FileViewScreen({Key? key, required this.filePath, required this.fileType, required this.isLocalFile, required this.completedCallback})
      : super(key: key);

  @override
  _FileViewScreenState createState() => _FileViewScreenState();
}

class _FileViewScreenState extends State<FileViewScreen> with WidgetsBindingObserver {
  // final Completer<FileViewerController> _controller = Completer<FileViewerController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          FileViewer(filePath: widget.filePath, fileType: widget.fileType, onViewCreated: widget.completedCallback, isLocalFile: widget.isLocalFile),
        ],
      ),
    );
  }
}

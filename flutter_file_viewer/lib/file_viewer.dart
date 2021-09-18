import 'dart:async';

import 'package:flutter/services.dart';

class FileViewer {
  static const MethodChannel _channel = MethodChannel('file_viewer');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static String get text1 {
    String rando = "Yeah yeah yeah";
    return rando;
  }
}

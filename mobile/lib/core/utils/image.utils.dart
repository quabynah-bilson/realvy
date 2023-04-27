import 'dart:io';

import 'package:flutter/services.dart';

Future<Uint8List> fileToBytes(String filePath) async =>
    await File(filePath).readAsBytes();

Future<Uint8List> assetToBytes(String assetPath) async {
  // Load asset file as bytes
  ByteData assetByteData = await rootBundle.load(assetPath);
  return assetByteData.buffer.asUint8List();
}

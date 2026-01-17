import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ImagesServices {
  Future<File> convertToJpgOrPng(File file, String newPath) async {
    final bytes = await file.readAsBytes();

    // Decode HEIC or any image
    final image = img.decodeImage(bytes);
    if (image == null) throw Exception("Cannot decode image");

    // Pilih format: JPG
    final jpg = img.encodeJpg(image, quality: 50);

    // Simpan file
    final newFile = File(newPath)..writeAsBytesSync(jpg);

    return newFile;
  }

  /// XFILE
  Future<XFile?> compressImage(XFile file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = "${dir.path}/${DateTime.now().toLocal().millisecondsSinceEpoch}.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 40, // 0-100 (semakin kecil semakin kecil ukuran)
      minWidth: 800, // optional
      minHeight: 800,
    );

    return result;
  }

  /// FILE
  Future<XFile?> compressImageFile(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = "${dir.path}/${DateTime.now().toLocal().millisecondsSinceEpoch}.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 40, // 0-100 (semakin kecil semakin kecil ukuran)
      minWidth: 800, // optional
      minHeight: 800,
    );

    return result;
  }
}

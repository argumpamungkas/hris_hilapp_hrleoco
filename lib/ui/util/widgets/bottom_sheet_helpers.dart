import 'dart:convert';
import 'dart:io';
import 'package:easy_hris/data/services/images_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetHelper {
  static Future<void> showUploadOptions(BuildContext context, Function(File file, String base64String) onImageSelected) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Upload dari Galeri"),
                onTap: () async {
                  Navigator.pop(ctx); // ✅ tutup bottom sheet dulu

                  final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 85);
                  if (picked != null) {
                    final file = File(picked.path);

                    final resultFileCompress = await ImagesServices().compressImageFile(file);

                    final base64 = base64Encode(await File(resultFileCompress!.path).readAsBytes());
                    onImageSelected(file, base64);
                  }
                  // Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Ambil Foto"),
                onTap: () async {
                  Navigator.pop(ctx); // ✅ tutup bottom sheet dulu

                  final picked = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                    preferredCameraDevice: CameraDevice.rear,
                    imageQuality: 85,
                  );
                  if (picked != null) {
                    final file = File(picked.path);

                    final resultFileCompress = await ImagesServices().compressImageFile(file);

                    final base64 = base64Encode(await File(resultFileCompress!.path).readAsBytes());
                    onImageSelected(file, base64);
                  }
                  // Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:easy_hris/data/services/images_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  static Future<void> showModalDetail(BuildContext context, {required String title, required Widget columnList}) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          width: 1.sw,
          child: Column(
            spacing: 8.h,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),

              columnList,

              // Column(
              //   spacing: 8.h,
              //   children: [
              //     ItemDetailTransaction(title: "Permit Date", value: formatDateReq(DateTime.parse(item.permitDate!))),
              //     ItemDetailTransaction(title: "Permit Type", value: item.permitTypeName ?? "-"),
              //     ItemDetailTransaction(title: "Reason Name", value: item.reasonName ?? "-"),
              //     ItemDetailTransaction(title: "Start Time", value: item.startTime ?? "00:00"),
              //     ItemDetailTransaction(title: "End Time", value: item.endTime ?? "00:00"),
              //     ItemDetailTransaction(title: "Meal", value: item.meal ?? ""),
              //     ItemDetailTransaction(title: "Note", value: item.note ?? ""),
              //     ItemDetailTransaction(title: "Attachment", value: item.attachment ?? "-"),
              //   ],
              // ),
            ],
          ),
        );
      },
    );
  }
}

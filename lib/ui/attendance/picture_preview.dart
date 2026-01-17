import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:provider/provider.dart';

import '../../providers/home_provider.dart';
import '../util/utils.dart';
import 'controller/attendance_controller.dart';
import 'controller/attendance_location_controllers.dart';

class PicturePreview extends StatelessWidget {
  static const routeName = "/picture_preview";

  const PicturePreview({super.key, required this.picture});

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    // print("CALL SINI");
    AttendanceController attendanceC = Provider.of<AttendanceController>(context);
    HomeProvider provHome = Provider.of<HomeProvider>(context);
    AttendanceLocationController attendanceLocationC = Provider.of<AttendanceLocationController>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.flip(flipX: true, child: Image.file(File(picture.path), fit: BoxFit.cover)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: const Icon(Icons.close, color: Colors.white, size: 36),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    showConfirmDialog(
                      context,
                      titleConfirm: "Confirm",
                      descriptionConfirm: "Are you sure you keep this attendance?",
                      action: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                        TextButton(
                          onPressed: () async {
                            showLoadingDialog(context);
                            await Future.delayed(const Duration(seconds: 1));
                            attendanceC
                                .attendanceUser(
                                  File(picture.path),
                                  provHome.attendanceToday,
                                  // attendanceLocationC.resultsLocationOffice!.number!
                                  //     .toUpperCase(),
                                )
                                .then((value) async {
                                  if (value) {
                                    await provHome.fetchHome().then((value) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    showFailedDialog(context, titleFailed: "Failed", descriptionFailed: "Attendance something wrong");
                                  }
                                });
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                    child: const Icon(Icons.check, color: Colors.white, size: 36),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:easy_hris/constant/routes.dart';
import 'package:flutter/material.dart';

import '../../../constant/exports.dart';
import '../../../providers/home_provider.dart';
import '../../util/utils.dart';
import '../camera_screen.dart';
import '../controller/attendance_controller.dart';

class AttendanceUser extends StatelessWidget {
  const AttendanceUser({super.key});

  @override
  Widget build(BuildContext context) {
    AttendanceController attendanceC = Provider.of<AttendanceController>(context, listen: false);
    HomeProvider provHome = Provider.of<HomeProvider>(context, listen: false);
    return GestureDetector(
      onTap: () async {
        showLoadingDialog(context);
        final result = await attendanceC.checkLocation(context, provHome.attendanceToday);

        if (!context.mounted) return;
        Navigator.pop(context);
        if (result) {
          await availableCameras().then((value) => Navigator.pushNamed(context, Routes.cameraScreen, arguments: value));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 100,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/fingerprint.png"))),
      ),
    );
  }
}

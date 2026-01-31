import 'package:easy_hris/ui/attendance/widgets/container_attendance.dart';
import 'package:easy_hris/ui/attendance/widgets/container_live_time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../providers/preferences_provider.dart';
import 'controller/attendance_controller.dart';
import 'controller/attendance_location_controllers.dart';

class AttendanceScreen extends StatefulWidget {
  static const routeName = "/attendance_screen";

  const AttendanceScreen({super.key, required this.locOffice});

  final String locOffice;

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AttendanceController>(context, listen: false).getPermission(context);

      /// menggunakan live attendance
      // Provider.of<AttendanceLocationController>(context, listen: false)
      //     .getLocationOffice(widget.locOffice);
    });
  }

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
    AttendanceLocationController attendanceLocController = Provider.of<AttendanceLocationController>(context);
    AttendanceController attendanceController = Provider.of<AttendanceController>(context);
    return WillPopScope(
      onWillPop: () async {
        attendanceLocController.clearData();
        attendanceController.clearData();
        return true;
      },
      child: Scaffold(
        backgroundColor: prov.isDarkTheme ? Theme.of(context).scaffoldBackgroundColor : ConstantColor.colorBlue,
        appBar: AppBar(
          backgroundColor: prov.isDarkTheme ? Theme.of(context).scaffoldBackgroundColor : ConstantColor.colorBlue,
          foregroundColor: Colors.white,
          title: const Text("Attendance", style: TextStyle(color: Colors.white)),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: ListView(children: [ContainerLiveTime(), const SizedBox(height: 16), const ContainerAttendance()]),
      ),
    );
  }
}

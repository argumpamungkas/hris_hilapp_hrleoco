import 'package:easy_hris/ui/attendance/widgets/user_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../constant/routes.dart';
import '../../../providers/preferences_provider.dart';
import 'attendance_user.dart';
import 'container_shift.dart';
import 'date_attendance_user.dart';

class ContainerAttendance extends StatelessWidget {
  const ContainerAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    // PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
          decoration: BoxDecoration(color: prov.isDarkTheme ? Colors.black : Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              Text("Schedule Shift Today", style: TextStyle(color: prov.isDarkTheme ? Colors.white : Colors.grey, fontSize: 12)),
              const SizedBox(height: 8),
              ContainerShift(),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: prov.isDarkTheme ? Colors.black : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: prov.isDarkTheme ? colorPurpleAccent : Colors.grey.shade100),
                ),
                child: Text(
                  "Selfie Photo is Required to Check In / Out",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: prov.isDarkTheme ? Colors.white : Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
              const AttendanceUser(),
              const SizedBox(height: 16),
              // const ContainerLocationOffice(),
              // const SizedBox(height: 16),
              const UserLocation(),
              const DateAttendanceUser(),
              // ElevatedButton(
              //   onPressed: () => Navigator.pushNamed(context, Routes.attendanceHistoryScreen),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: colorBlueDark,
              //     foregroundColor: Colors.white,
              //     textStyle: const TextStyle(fontWeight: FontWeight.bold),
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              //     minimumSize: const Size.fromHeight(46),
              //   ),
              //   child: const Text("History"),
              // ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

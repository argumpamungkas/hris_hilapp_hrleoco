import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';

class ContainerHistoryAttendance extends StatelessWidget {
  const ContainerHistoryAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProv, _) {
        switch (homeProv.resultStatusAttendanceToday) {
          case ResultStatus.hasData:
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusGeometry.circular(8.w),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ConstantColor.colorBlue, ConstantColor.colorBlue.withAlpha(120), ConstantColor.colorBlue],
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "History Attendance",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16.sp),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.attendanceHistory);
                    },
                    label: Text("View"),
                    icon: Icon(Icons.visibility_outlined),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8.w)),
                    ),
                  ),
                ],
              ),
            );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}

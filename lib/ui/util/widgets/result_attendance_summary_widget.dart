import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/exports.dart';
import '../../../data/models/attendance_summary.dart';
import '../../../providers/preferences_provider.dart';
import '../../attendance_summary/widgets/item_attendance_summary.dart';
import '../../attendance_summary/widgets/item_info_attendance.dart';
import '../utils.dart';
import 'data_not_found.dart';

class ResultAttendanceSummaryWidget extends StatelessWidget {
  const ResultAttendanceSummaryWidget({super.key, required this.date, required this.attendanceSummary, required this.listAttendanceSummary});

  final DateTime date;
  final AttendanceSummary? attendanceSummary;
  final List<ResultAttendanceSummary> listAttendanceSummary;

  Color checkColor(ResultAttendanceSummary items) {
    Color colorStatus;
    if (items.color.toUpperCase() == "GREEN") {
      colorStatus = Colors.greenAccent.shade400;
    } else if (items.color.toUpperCase() == "BLUE") {
      colorStatus = Colors.blueAccent;
    } else if (items.color.toUpperCase() == "ORANGE") {
      colorStatus = Colors.orangeAccent;
    } else if (items.color.toUpperCase() == "PURPLE") {
      colorStatus = Colors.purpleAccent;
    } else if (items.color.toUpperCase() == "PINK") {
      colorStatus = Colors.pinkAccent;
    } else if (items.color.toUpperCase() == "GRAY") {
      colorStatus = Colors.grey;
    } else {
      colorStatus = Colors.redAccent;
    }
    return colorStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Container(
          color: prov.isDarkTheme ? Theme.of(context).colorScheme.background : Colors.white,
          width: 1.sw,
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Text(
                formatTimeMonth(date),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 6.w.h,
                children: [
                  ItemInfoAttendance(info: "Not Yet", total: attendanceSummary?.notYet ?? 0, color: Colors.grey),
                  ItemInfoAttendance(info: "Absence", total: attendanceSummary?.absence ?? 0, color: Colors.redAccent),
                  ItemInfoAttendance(info: "Permit", total: attendanceSummary?.permit ?? 0, color: Colors.blueAccent),
                  ItemInfoAttendance(info: "Working", total: attendanceSummary?.working ?? 0, color: Colors.greenAccent.shade400),
                  ItemInfoAttendance(info: "Late", total: attendanceSummary?.late ?? 0, color: Colors.orangeAccent),
                ],
              ),
              SizedBox(height: 8),
              listAttendanceSummary.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: listAttendanceSummary.length,
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                        itemBuilder: (context, index) {
                          ResultAttendanceSummary items = listAttendanceSummary[index];
                          DateTime dateTime = DateTime.parse(items.transDate);
                          var date = formatDateNow(dateTime);
                          final colorStatus = checkColor(items);
                          return Column(
                            children: [ItemAttendanceSummary(items: items, date: date, colorStatus: colorStatus)],
                          );
                        },
                      ),
                    )
                  : const DataEmpty(dataName: "Attendance Summary"),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../data/models/attendance_summary.dart';
import '../../providers/attendances/attendance_summary_provider.dart';
import '../../providers/auth/profile_provider.dart';
import '../../providers/preferences_provider.dart';
import '../util/utils.dart';
import '../util/widgets/app_bar_custom.dart';
import '../util/widgets/result_attendance_summary_widget.dart';

class AttendanceSummaryScreen extends StatelessWidget {
  const AttendanceSummaryScreen({super.key, required this.result});

  final AttendanceSummary result;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendanceSummaryProvider(),
      child: Scaffold(
        appBar: AppbarCustom.appbar(
          context,
          title: "Attendance Summary",
          leadingBack: true,
          action: [
            Consumer3<AttendanceSummaryProvider, PreferencesProvider, ProfileProvider>(
              builder: (context, provTeam, provPref, provProf, _) {
                return provTeam.resultStatus != ResultStatus.loading
                    ? Material(
                        color: provPref.isDarkTheme ? Colors.black : Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: provPref.isDarkTheme ? ConstantColor.colorBlue : Colors.grey.shade100),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          child: InkWell(
                            onTap: () async {
                              // var dateJoin = DateFormat("yyyy-MM-dd").parse(provProf.userProfile!.dateSign!);
                              // provTeam.changeDate(context, dateJoin.year);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(formatDatePeriod(provTeam.initDate), style: TextStyle(fontSize: 9.sp)),
                                SizedBox(width: 4.w),
                                Icon(Iconsax.calendar_1_outline, size: 12.w),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),
          ],
        ),
        body: Consumer2<AttendanceSummaryProvider, PreferencesProvider>(
          builder: (context, provAttendance, prov, _) {
            switch (provAttendance.resultStatus) {
              case ResultStatus.loading:
                return Center(child: CircularProgressIndicator());
              case ResultStatus.error:
                return Center(child: Text("Error ${provAttendance.message}"));
              case ResultStatus.hasData:
                return ResultAttendanceSummaryWidget(
                  date: provAttendance.initDate,
                  attendanceSummary: provAttendance.attendanceSummary,
                  listAttendanceSummary: provAttendance.listAttendanceSummary,
                );
              default:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

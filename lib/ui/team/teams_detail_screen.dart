import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import '../../constant/constant.dart';
import '../../constant/exports.dart';
import '../../providers/auth/profile_provider.dart';
import '../../providers/preferences_provider.dart';
import '../../providers/teams_detail_provider.dart';
import '../util/utils.dart';
import '../util/widgets/app_bar_custom.dart';
import '../util/widgets/result_attendance_summary_widget.dart';

class TeamsDetailScreen extends StatelessWidget {
  const TeamsDetailScreen({super.key, required this.dataEmployee});

  final Map<String, dynamic> dataEmployee;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TeamsDetailProvider(dataEmployee),
      child: Scaffold(
        appBar: AppbarCustom.appbar(
          context,
          title: "Attendance Teams",
          leadingBack: true,
          action: [
            Consumer3<TeamsDetailProvider, PreferencesProvider, ProfileProvider>(
              builder: (context, provTeam, provPref, provProf, _) {
                return provTeam.resultStatus != ResultStatus.loading
                    ? Material(
                        color: provPref.isDarkTheme ? Colors.black : Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: provPref.isDarkTheme ? ConstantColor.colorPurpleAccent : Colors.grey.shade100),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          child: InkWell(
                            onTap: () async {
                              var dateJoin = DateFormat("yyyy-MM-dd").parse(provTeam.dateSign);
                              provTeam.changeDate(context, dateJoin.year);
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Consumer<TeamsDetailProvider>(
              builder: (context, prov, _) {
                return Card(
                  child: ListTile(
                    leading: Container(
                      width: 42.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage(prov.imageUrl), fit: BoxFit.cover, filterQuality: FilterQuality.medium),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    title: Text(prov.nameEmployee, maxLines: 1, overflow: TextOverflow.ellipsis),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(color: colorPurpleAccent, borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        prov.yearsWork,
                        style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer<TeamsDetailProvider>(
                builder: (context, prov, _) {
                  switch (prov.resultStatus) {
                    case ResultStatus.loading:
                      return Center(child: CircularProgressIndicator());
                    case ResultStatus.error:
                      return Center(child: Text(prov.message));
                    case ResultStatus.hasData:
                      return ResultAttendanceSummaryWidget(
                        date: prov.initDate,
                        attendanceSummary: prov.attendanceSummary,
                        listAttendanceSummary: prov.listAttendanceSummary,
                      );
                    default:
                      return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

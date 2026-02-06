import 'package:easy_hris/data/models/response/attendance_summary_model.dart';
import 'package:easy_hris/providers/attendances/attendance_summary_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/exports.dart';
import '../../../providers/preferences_provider.dart';
import 'item_attendance_summary.dart';
import 'item_info_attendance.dart';
import '../../util/utils.dart';

class ResultAttendanceSummaryWidget extends StatelessWidget {
  const ResultAttendanceSummaryWidget({super.key, required this.date, required this.attendanceSummary});

  final DateTime date;
  final AttendanceSummaryModel? attendanceSummary;

  Color checkColor(DetailAttendanceSummary items) {
    final hex = items.color!.replaceAll('#', '');
    return Color(int.parse('0xFF$hex'));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PreferencesProvider, AttendanceSummaryProvider>(
      builder: (context, prov, provSum, _) {
        return Container(
          color: prov.isDarkTheme ? Theme.of(context).colorScheme.background : Colors.white,
          width: 1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 8.h),
              Column(
                children: [
                  Text(
                    formatTimeMonth(date),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    spacing: 6.w,
                    runSpacing: 6.h,
                    children: provSum.listFilter
                        .map(
                          (e) => InkWell(
                            onTap: () {
                              provSum.onFilter(e.status!);
                            },
                            child: ItemInfoAttendance(info: e.status!, color: e.status == provSum.lockFilter ? Colors.grey : checkColor(e)),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  "${provSum.isFilter ? provSum.listFilterAttendanceSummary.length : provSum.attendanceSummaryModel!.details.length} Data Found",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
              SizedBox(height: 4.h),
              Consumer<AttendanceSummaryProvider>(
                builder: (context, provSummary, _) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: provSummary.isFilter ? provSummary.listFilterAttendanceSummary.length : attendanceSummary!.details.length,
                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                      itemBuilder: (context, index) {
                        DetailAttendanceSummary items = provSummary.isFilter
                            ? provSummary.listFilterAttendanceSummary[index]
                            : attendanceSummary!.details[index];
                        final colorStatus = checkColor(items);
                        return Column(
                          children: [ItemAttendanceSummary(items: items, colorStatus: colorStatus)],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

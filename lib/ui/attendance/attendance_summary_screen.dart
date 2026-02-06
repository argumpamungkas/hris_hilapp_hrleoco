import 'package:easy_hris/ui/util/widgets/shimmer_list_load_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../data/models/attendance_summary.dart';
import '../../providers/attendances/attendance_summary_provider.dart';
import '../../providers/auth/profile_provider.dart';
import '../../providers/preferences_provider.dart';
import '../util/utils.dart';
import '../util/widgets/app_bar_custom.dart';
import 'widgets/result_attendance_summary_widget.dart';

class AttendanceSummaryScreen extends StatelessWidget {
  const AttendanceSummaryScreen({super.key});

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
              builder: (context, prov, provPref, provProf, _) {
                return prov.resultStatus != ResultStatus.loading
                    ? InkWell(
                        onTap: () {
                          showMonthPicker(
                            context: context,
                            // headerTitle: Text("Select Month"),
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now().toLocal(),
                            // monthPickerDialogSettings: ,
                            monthPickerDialogSettings: MonthPickerDialogSettings(
                              headerSettings: PickerHeaderSettings(
                                headerBackgroundColor: provPref.isDarkTheme ? Colors.black : ConstantColor.colorBlue,
                              ),
                              dateButtonsSettings: PickerDateButtonsSettings(
                                selectedDateRadius: 8.w,
                                selectedMonthBackgroundColor: ConstantColor.colorBlue,
                              ),
                              dialogSettings: PickerDialogSettings(
                                dialogRoundedCornersRadius: 16.w,
                                dialogBorderSide: BorderSide(color: provPref.isDarkTheme ? ConstantColor.colorBlue : Colors.transparent),
                              ),
                            ),
                          ).then((value) {
                            if (value != null) {
                              prov.onChangeMonth(value);
                            }
                          });
                        },
                        child: Material(
                          color: provPref.isDarkTheme ? Colors.black : Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: provPref.isDarkTheme ? ConstantColor.colorBlue : Colors.grey.shade100),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(formatDatePeriod(prov.initDate), style: TextStyle(fontSize: 9.sp)),
                                SizedBox(width: 4.w),
                                Icon(Iconsax.calendar_1_outline, size: 12.w, color: Colors.black),
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
                return ShimmerListLoadData();
              case ResultStatus.error:
                return Center(child: Text("Error ${provAttendance.message}"));
              case ResultStatus.hasData:
                return SafeArea(
                  child: ResultAttendanceSummaryWidget(date: provAttendance.initDate, attendanceSummary: provAttendance.attendanceSummaryModel),
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

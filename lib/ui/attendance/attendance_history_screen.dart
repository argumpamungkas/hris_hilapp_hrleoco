import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/attendances/attendance_history_provider.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/attendance/widgets/item_attendance_history.dart';
import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../util/widgets/show_dialog_picker_year.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendanceHistoryProvider(),
      child: Scaffold(
        appBar: AppbarCustom.appbar(
          context,
          title: "Attendance History",
          leadingBack: false,
          action: [
            Consumer2<AttendanceHistoryProvider, PreferencesProvider>(
              builder: (context, prov, provPref, _) {
                return InkWell(
                  onTap: () {
                    showMonthPicker(
                      context: context,
                      // headerTitle: Text("Select Month"),
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now().toLocal(),
                      // monthPickerDialogSettings: ,
                      monthPickerDialogSettings: MonthPickerDialogSettings(
                        headerSettings: PickerHeaderSettings(headerBackgroundColor: provPref.isDarkTheme ? Colors.black : ConstantColor.colorBlue),
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
                  child: Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: provPref.isDarkTheme ? Colors.black : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.w),
                      border: Border.all(color: provPref.isDarkTheme ? ConstantColor.colorBlue : Colors.grey.shade200),
                    ),
                    child: Row(
                      spacing: 4.w,
                      children: [
                        Text(
                          prov.dateMonth,
                          style: TextStyle(fontSize: 12.sp, color: provPref.isDarkTheme ? Colors.white : Colors.black),
                        ),
                        Icon(Icons.calendar_month, size: 12.w, color: provPref.isDarkTheme ? Colors.white : Colors.black),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Consumer<AttendanceHistoryProvider>(
            builder: (context, prov, _) {
              switch (prov.resultStatus) {
                case ResultStatus.loading:
                  return Center(child: CupertinoActivityIndicator());
                case ResultStatus.noData:
                  return Center(child: Text("History in ${prov.dateMonth} is Empty"));
                case ResultStatus.error:
                  return Center(
                    child: Column(
                      children: [
                        Text(prov.message),
                        TextButton(
                          onPressed: () {
                            // prov.fetchAttendanceHistory(from: prov.dateFrom.text, to: prov.dateTo.text);
                          },
                          child: Text("Refresh"),
                        ),
                      ],
                    ),
                  );

                case ResultStatus.hasData:
                  return ListView.builder(
                    itemCount: prov.listAttendance.length,
                    itemBuilder: (context, index) {
                      final item = prov.listAttendance[index];

                      return ItemAttendanceHistory(item: item, baseUrl: prov.baseUrl);
                    },
                  );

                default:
                  return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/constant.dart';
import '../../../constant/routes.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/preferences_provider.dart';
import '../../util/utils.dart';

class AttendanceSummaryContainer extends StatelessWidget {
  const AttendanceSummaryContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provPref, _) {
        return Card(
          surfaceTintColor: provPref.isDarkTheme ? Colors.black : Colors.white,
          color: provPref.isDarkTheme ? Colors.black : Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
            side: BorderSide(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(color: provPref.isDarkTheme ? Colors.black : Colors.white, borderRadius: BorderRadius.circular(16.w)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "My Attendance Summary",
                          style: TextStyle(
                            height: 0,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: provPref.isDarkTheme ? Colors.white : Colors.grey.shade600,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showInfoSnackbar(context, "Feature on Progress");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(color: ConstantColor.colorPurpleAccent, fontSize: 12.sp),
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     // Navigator.pushNamed(
                      //     //   context,
                      //     //   Routes.attendanceSummaryScreen,
                      //     //   // arguments: prov.attendanceSummary,
                      //     // );
                      //
                      //     showInfoSnackbar(context, "Feature on Progress");
                      //   },
                      //   style: TextButton.styleFrom(
                      //     textStyle: TextStyle(color: Colors.blue, fontSize: 12.sp),
                      //     padding: EdgeInsets.zero,
                      //   ),
                      //   child: const Text("View All"),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: PieChart(
                    dataMap: {'Not Yet': 3, 'Absence': 2, 'Permit': 1, 'Working': 12, 'Late': 1},
                    colorList: [Colors.grey.shade200, Colors.red, Colors.blueAccent.shade100, Colors.green.shade300, Colors.orangeAccent],
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 100.w,
                    chartType: ChartType.ring,
                    formatChartValues: (value) {
                      return "${value.toInt()}";
                    },
                    legendOptions: LegendOptions(
                      legendTextStyle: TextStyle(fontSize: 9.sp),
                      legendPosition: LegendPosition.right,
                    ),
                    centerText: DateFormat("MMM yyyy").format(DateTime.now()),
                    centerTextStyle: TextStyle(fontSize: 9.sp, color: Colors.black),
                    chartValuesOptions: ChartValuesOptions(showChartValuesOutside: true),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

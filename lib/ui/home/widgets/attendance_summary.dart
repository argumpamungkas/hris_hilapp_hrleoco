import 'package:easy_hris/providers/home_provider.dart';
import 'package:easy_hris/ui/home/widgets/card_home_custom.dart';
import 'package:easy_hris/ui/util/widgets/loading_shimmer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../providers/preferences_provider.dart';

class AttendanceSummaryContainer extends StatelessWidget {
  const AttendanceSummaryContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provPref, _) {
        return CardHomeCustom(
          title: "Attendance Summary",
          subtitle: "Tracking individual presence for the current month",
          widget: Consumer<HomeProvider>(
            builder: (context, homeProv, _) {
              switch (homeProv.resultStatusAttendanceToday) {
                case ResultStatus.loading:
                  return LoadingShimmerCard();
                case ResultStatus.hasData:
                  return Column(
                    children: [
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          label: Text("View Detail"),
                          icon: Icon(Icons.file_present_rounded),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ConstantColor.bgIcon,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8.w)),
                          ),
                        ),
                      ),
                    ],
                  );
                default:
                  return SizedBox.shrink();
              }
            },
          ),
        );
      },
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:easy_hris/ui/attendance_history/widgets/item_attendance_history.dart';
import 'package:easy_hris/ui/attendance_history/widgets/popup_pic_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import '../../constant/constant.dart';
import '../../constant/exports.dart';
import '../../data/models/history_attendance.dart';
import '../../providers/attendances/attendance_history_provider.dart';
import '../../providers/auth/profile_provider.dart';
import '../../providers/preferences_provider.dart';
import '../util/utils.dart';
import '../util/widgets/app_bar_custom.dart';
import '../util/widgets/card_info.dart';
import '../util/widgets/data_not_found.dart';
import '../util/widgets/shimmer_list_load_data.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendanceHistoryProvider(),
      child: Scaffold(
        appBar: appBarCustom(
          context,
          title: "Attendance History",
          leadingBack: true,
          action: [
            Consumer3<AttendanceHistoryProvider, PreferencesProvider, ProfileProvider>(
              builder: (context, provHistory, provPref, provProf, _) {
                return Material(
                  color: provPref.isDarkTheme ? Colors.black : Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: provPref.isDarkTheme ? ConstantColor.colorPurpleAccent : Colors.grey.shade100),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: provHistory.resultStatus != ResultStatus.loading
                        ? InkWell(
                            onTap: () async {
                              // var dateJoin = DateFormat("yyyy-MM-dd").parse(provProf.userProfile!.dateSign!);
                              // provHistory.changeDate(context, dateJoin.year);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(formatDatePeriod(provHistory.initDate), style: TextStyle(fontSize: 9.sp)),
                                SizedBox(width: 4.w),
                                Icon(Iconsax.calendar_1_outline, size: 12.w),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Consumer<AttendanceHistoryProvider>(
          builder: (context, provHistory, _) {
            switch (provHistory.resultStatus) {
              case ResultStatus.loading:
                return const ShimmerListLoadData();
              case ResultStatus.noData:
                return DataEmpty(dataName: "Attendance History ${formatDatePeriod(provHistory.initDate)}");
              case ResultStatus.error:
                return FadeInUp(
                  child: Center(
                    child: CardInfo(
                      iconData: Iconsax.info_circle_outline,
                      colorIcon: Colors.red,
                      title: "Error",
                      description: provHistory.message,
                      onPressed: () {
                        provHistory.fetchHistoryAttendance(provHistory.initDate);
                      },
                      titleButton: "Refresh",
                      colorTitle: Colors.red,
                      buttonStyle: ElevatedButton.styleFrom(backgroundColor: ConstantColor.colorBlueDark, foregroundColor: Colors.white),
                    ),
                  ),
                );
              case ResultStatus.hasData:
                return RefreshIndicator(
                  onRefresh: () async {
                    provHistory.fetchHistoryAttendance(provHistory.initDate);
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                    itemCount: provHistory.listAttendance.length,
                    itemBuilder: (context, index) {
                      ResultsHistoryAttendance item = provHistory.listAttendance[index];
                      late String? day, month, year, timeIn, timeOut;
                      if (item.dateIn != null) {
                        var dateFormatDefautlt = DateFormat("yyyy-MM-dd").parse(item.dateIn!);
                        day = formatTimeDay(dateFormatDefautlt);
                        month = formatTimeMonth(dateFormatDefautlt);
                        year = formatTimeyear(dateFormatDefautlt);
                      }

                      if (item.timeIn != null) {
                        var dateFormatDefautlt = DateFormat("HH:mm:ss").parse(item.timeIn!);
                        timeIn = formatTimeAttendance(dateFormatDefautlt);
                      }

                      if (item.timeOut != null) {
                        var dateFormatDefautlt = DateFormat("HH:mm:ss").parse(item.timeOut!);
                        timeOut = formatTimeAttendance(dateFormatDefautlt);
                      }

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return PopupPicHistory(link: provHistory.linkServer, fotoIn: item.fotoIn, fotoOut: item.fotoOut);
                                },
                              );
                            },
                            child: ItemAttendanceHistory(
                              day: item.dateIn != null ? day! : "-",
                              month: item.dateIn != null ? month! : "-",
                              year: item.dateIn != null ? year! : "-",
                              timeIn: item.timeIn != null ? timeIn! : "-",
                              timeOut: item.timeOut != null ? timeOut! : "-",
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../../constant/constant.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/preferences_provider.dart';
import '../../util/utils.dart';

class AttendanceWidget extends StatelessWidget {
  AttendanceWidget({super.key});

  final DateTime _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer2<PreferencesProvider, HomeProvider>(
      builder: (context, provPref, homeProv, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 8.h),
            Card(
              color: provPref.isDarkTheme ? Colors.black : Colors.white,
              surfaceTintColor: provPref.isDarkTheme ? Colors.black : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.w),
                side: BorderSide(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
              ),
              elevation: 4,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Attendance Today",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: provPref.isDarkTheme ? Colors.white : Colors.grey.shade600,
                                ),
                              ),

                              Text(
                                formatDateNow(_now),
                                style: TextStyle(color: provPref.isDarkTheme ? Colors.white : Colors.grey.shade600, fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ),

                        Flexible(
                          child: TimerBuilder.periodic(
                            const Duration(seconds: 1),
                            builder: (context) {
                              DateTime dateRunning = DateTime.now();
                              return Text(
                                formatClock(dateRunning),
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 4.h,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          spacing: 4.w,
                          children: [
                            Flexible(
                              child: homeProv.resultStatusLocation == ResultStatus.loading
                                  ? Text(
                                      "Loading get your Location...",
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 9.sp, color: Colors.grey),
                                    )
                                  : RichText(
                                      text: TextSpan(
                                        text: "Your current Location ",
                                        children: [TextSpan(text: homeProv.canAttendance ? 'can check in' : 'can not check in')],
                                        style: TextStyle(fontSize: 9.sp, color: Colors.grey),
                                      ),
                                      maxLines: 1,
                                    ),
                              // child: Text(
                              //   "Your current Location ${homeProv.canAttendance ? 'can check in' : 'can not check in'}",
                              //   maxLines: 1,
                              //   style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade700),
                              // ),
                            ),
                            homeProv.resultStatusLocation == ResultStatus.loading
                                ? CupertinoActivityIndicator()
                                : Icon(
                                    homeProv.canAttendance ? Icons.check_circle_outline : Iconsax.close_circle_outline,
                                    size: 16.w,
                                    color: homeProv.canAttendance ? Colors.green : Colors.red.shade900,
                                  ),
                          ],
                        ),
                        Builder(
                          builder: (context_) {
                            if (homeProv.resultStatusLocation == ResultStatus.loading) {
                              return Shimmer.fromColors(
                                baseColor: provPref.isDarkTheme ? ConstantColor.colorBlueDark : Colors.grey.shade300,
                                highlightColor: provPref.isDarkTheme ? ConstantColor.colorPurpleAccent : Colors.grey.shade100,
                                child: Container(
                                  width: 0.7.sw,
                                  height: 30.h,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: provPref.isDarkTheme ? Colors.transparent : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
                                  ),
                                ),
                              );
                            }

                            if (homeProv.resultStatusLocation == ResultStatus.error) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                width: 0.7.sw,
                                height: 30.h,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: provPref.isDarkTheme ? Colors.transparent : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
                                ),
                                child: Marquee(
                                  text: homeProv.message,
                                  style: TextStyle(fontSize: 10.sp, color: Colors.red),
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  blankSpace: 20,
                                  velocity: 50,
                                  pauseAfterRound: const Duration(seconds: 1),
                                  accelerationDuration: const Duration(seconds: 1),
                                  accelerationCurve: Curves.linear,
                                  decelerationDuration: const Duration(seconds: 1),
                                  decelerationCurve: Curves.easeOut,
                                ),
                              );
                            }

                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              width: 0.7.sw,
                              height: 30.h,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: provPref.isDarkTheme ? Colors.transparent : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
                              ),
                              child: Row(
                                spacing: 4.w,
                                children: [
                                  Icon(Iconsax.location_outline, color: Colors.red.shade700, size: 16.w),
                                  Expanded(
                                    child: Marquee(
                                      text: homeProv.address,
                                      style: TextStyle(fontSize: 10.sp, color: provPref.isDarkTheme ? Colors.white : Colors.grey),
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      blankSpace: 20,
                                      velocity: 50,
                                      pauseAfterRound: const Duration(seconds: 1),
                                      accelerationDuration: const Duration(seconds: 1),
                                      accelerationCurve: Curves.linear,
                                      decelerationDuration: const Duration(seconds: 1),
                                      decelerationCurve: Curves.easeOut,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    Visibility(
                      visible: homeProv.resultStatusLocation == ResultStatus.loading
                          ? false
                          : homeProv.resultStatusLocation == ResultStatus.hasData && homeProv.canAttendance
                          ? false
                          : true,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 8.h),
                            ElevatedButton.icon(
                              onPressed: () {
                                homeProv.fetchCurrentLocation();
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(0.3.sw, 20.h),
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                backgroundColor: Colors.orange.shade700,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
                              ),
                              label: Text("Sync Location", style: TextStyle(fontSize: 10.sp), maxLines: 1),
                              icon: Icon(Icons.refresh),
                              iconAlignment: IconAlignment.end,
                            ),
                            SizedBox(height: 4.h),
                          ],
                        ),
                      ),
                    ),

                    // Text("Your")
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _informationAttendance(title: "Check In", time: "00:00", colorIcon: Colors.green, colorBackground: Colors.green.shade50),

                          SizedBox(width: 24.w),

                          _informationAttendance(title: "Check Out", time: "00:00", colorIcon: Colors.red, colorBackground: Colors.red.shade50),
                        ],
                      ),
                    ),

                    Divider(thickness: 1, color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        spacing: 16.w,
                        children: [
                          _buttonAttendance(
                            title: "Check In",
                            icon: Icons.arrow_circle_down,
                            background: Colors.green,
                            iconAlignment: IconAlignment.end,
                            onPressed: () {},
                          ),
                          SizedBox(
                            height: 26.h,
                            child: VerticalDivider(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
                          ),
                          _buttonAttendance(
                            title: "Check Out",
                            icon: Icons.arrow_circle_up,
                            background: Colors.red,
                            iconAlignment: IconAlignment.start,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _informationAttendance({required String title, required String time, required Color colorIcon, required Color colorBackground}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(color: colorBackground, borderRadius: BorderRadius.circular(12.w)),
          child: Row(
            spacing: 6.w,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.access_time, color: colorIcon),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Check In",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10.sp),
                  ),
                  Text(
                    "00:00",
                    style: TextStyle(color: colorIcon, fontWeight: FontWeight.bold, fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttonAttendance({
    required String title,
    required IconData icon,
    required Color background,
    required IconAlignment? iconAlignment,
    required void Function()? onPressed,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {},
        // onPressed: null,
        label: Text(title, style: TextStyle(fontSize: 12.sp)),
        icon: Icon(icon, size: 16.w),
        iconAlignment: iconAlignment,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
        ),
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:easy_hris/ui/util/widgets/dialog_helpers.dart';
import 'package:easy_hris/ui/util/widgets/loading_shimmer_card.dart';
import 'package:easy_hris/ui/util/widgets/shimmer_list_load_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../../constant/constant.dart';
import '../../../constant/routes.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/preferences_provider.dart';
import '../../util/utils.dart';
import '../../util/widgets/card_info.dart';

class AttendanceWidget extends StatelessWidget {
  AttendanceWidget({super.key});

  final DateTime _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer2<PreferencesProvider, HomeProvider>(
      builder: (context, provPref, homeProv, _) {
        switch (homeProv.resultStatusAttendanceToday) {
          case ResultStatus.loading:
            return LoadingShimmerCard();
          case ResultStatus.error:
            return Center(
              child: CardInfo(
                iconData: Iconsax.info_circle_outline,
                colorIcon: Colors.red,
                title: "Employee",
                description: homeProv.message,
                onPressed: () {
                  homeProv.init();
                  homeProv.fetchCurrentLocation(provPref.configModel!);
                },
                titleButton: "Re-Login",
                colorTitle: Colors.red,
                buttonStyle: ElevatedButton.styleFrom(backgroundColor: ConstantColor.colorBlueDark, foregroundColor: Colors.white),
              ),
            );
          case ResultStatus.hasData:
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
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: provPref.isDarkTheme ? Colors.white : Colors.black,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),

                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                homeProv.shiftUserModel!.shiftName!.isEmpty ? "Shift Not Found" : homeProv.shiftUserModel!.shiftName!,
                                style: TextStyle(fontSize: 16.sp, color: provPref.isDarkTheme ? Colors.white : Colors.grey.shade700),
                              ),
                              Text(
                                homeProv.shiftUserModel!.shiftName!.isEmpty
                                    ? "Your shift has not been registered"
                                    : "${homeProv.shiftUserModel?.shiftStart?.substring(0, 5)} - ${homeProv.shiftUserModel?.shiftEnd?.substring(0, 5)}",
                                style: TextStyle(
                                  fontSize: homeProv.shiftUserModel!.shiftName!.isEmpty ? 13.sp : 16.sp,
                                  color: provPref.isDarkTheme ? Colors.white : Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.stretch,
                        //   spacing: 4.h,
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       mainAxisSize: MainAxisSize.max,
                        //       spacing: 4.w,
                        //       children: [
                        //         Flexible(
                        //           child: homeProv.resultStatusLocation == ResultStatus.loading
                        //               ? Text(
                        //                   "Loading get your Location...",
                        //                   maxLines: 1,
                        //                   style: TextStyle(fontSize: 9.sp, color: Colors.grey),
                        //                 )
                        //               : RichText(
                        //                   text: TextSpan(
                        //                     text: "Your current Location ",
                        //                     children: [TextSpan(text: homeProv.canAttendance ? 'can do Attendance' : "can't do Attendance")],
                        //                     style: TextStyle(fontSize: 9.sp, color: Colors.grey),
                        //                   ),
                        //                   maxLines: 1,
                        //                 ),
                        //           // child: Text(
                        //           //   "Your current Location ${homeProv.canAttendance ? 'can check in' : 'can not check in'}",
                        //           //   maxLines: 1,
                        //           //   style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade700),
                        //           // ),
                        //         ),
                        //         homeProv.resultStatusLocation == ResultStatus.loading
                        //             ? CupertinoActivityIndicator()
                        //             : Icon(
                        //                 homeProv.canAttendance ? Icons.check_circle_outline : Iconsax.close_circle_outline,
                        //                 size: 16.w,
                        //                 color: homeProv.canAttendance ? Colors.green : Colors.red.shade900,
                        //               ),
                        //       ],
                        //     ),
                        //     Builder(
                        //       builder: (context_) {
                        //         if (homeProv.resultStatusLocation == ResultStatus.loading) {
                        //           return Shimmer.fromColors(
                        //             baseColor: provPref.isDarkTheme ? ConstantColor.colorBlueDark : Colors.grey.shade300,
                        //             highlightColor: provPref.isDarkTheme ? ConstantColor.ConstantColor.colorBlue : Colors.grey.shade100,
                        //             child: Container(
                        //               width: 0.7.sw,
                        //               height: 30.h,
                        //               padding: EdgeInsets.all(8),
                        //               decoration: BoxDecoration(
                        //                 color: provPref.isDarkTheme ? Colors.transparent : Colors.grey.shade200,
                        //                 borderRadius: BorderRadius.circular(8),
                        //                 border: Border.all(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
                        //               ),
                        //             ),
                        //           );
                        //         }
                        //
                        //         if (homeProv.resultStatusLocation == ResultStatus.error) {
                        //           return Container(
                        //             margin: EdgeInsets.symmetric(horizontal: 8.w),
                        //             width: 0.7.sw,
                        //             height: 30.h,
                        //             padding: EdgeInsets.all(8),
                        //             decoration: BoxDecoration(
                        //               color: provPref.isDarkTheme ? Colors.transparent : Colors.grey.shade200,
                        //               borderRadius: BorderRadius.circular(8),
                        //               border: Border.all(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
                        //             ),
                        //             child: Marquee(
                        //               text: homeProv.message,
                        //               style: TextStyle(fontSize: 10.sp, color: Colors.red),
                        //               scrollAxis: Axis.horizontal,
                        //               crossAxisAlignment: CrossAxisAlignment.center,
                        //               blankSpace: 20,
                        //               velocity: 50,
                        //               pauseAfterRound: const Duration(seconds: 1),
                        //               accelerationDuration: const Duration(seconds: 1),
                        //               accelerationCurve: Curves.linear,
                        //               decelerationDuration: const Duration(seconds: 1),
                        //               decelerationCurve: Curves.easeOut,
                        //             ),
                        //           );
                        //         }
                        //
                        //         return Container(
                        //           margin: EdgeInsets.symmetric(horizontal: 8.w),
                        //           width: 0.7.sw,
                        //           height: 30.h,
                        //           padding: EdgeInsets.all(8),
                        //           decoration: BoxDecoration(
                        //             color: provPref.isDarkTheme ? Colors.transparent : Colors.grey.shade200,
                        //             borderRadius: BorderRadius.circular(8),
                        //             border: Border.all(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
                        //           ),
                        //           child: Row(
                        //             spacing: 4.w,
                        //             children: [
                        //               Icon(Iconsax.location_outline, color: Colors.red.shade700, size: 16.w),
                        //               Expanded(
                        //                 child: Marquee(
                        //                   text: homeProv.address,
                        //                   style: TextStyle(fontSize: 10.sp, color: provPref.isDarkTheme ? Colors.white : Colors.grey),
                        //                   scrollAxis: Axis.horizontal,
                        //                   crossAxisAlignment: CrossAxisAlignment.center,
                        //                   blankSpace: 20,
                        //                   velocity: 50,
                        //                   pauseAfterRound: const Duration(seconds: 1),
                        //                   accelerationDuration: const Duration(seconds: 1),
                        //                   accelerationCurve: Curves.linear,
                        //                   decelerationDuration: const Duration(seconds: 1),
                        //                   decelerationCurve: Curves.easeOut,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ],
                        // ),
                        // Visibility(
                        //   visible: homeProv.resultStatusLocation == ResultStatus.loading
                        //       ? false
                        //       : homeProv.resultStatusLocation == ResultStatus.hasData && homeProv.canAttendance
                        //       ? false
                        //       : true,
                        //   child: Center(
                        //     child: Column(
                        //       children: [
                        //         SizedBox(height: 8.h),
                        //         ElevatedButton.icon(
                        //           onPressed: () {
                        //             homeProv.fetchCurrentLocation(provPref.configModel!);
                        //           },
                        //           style: ElevatedButton.styleFrom(
                        //             fixedSize: Size(0.3.sw, 20.h),
                        //             padding: EdgeInsets.symmetric(horizontal: 2.w),
                        //             backgroundColor: Colors.orange.shade700,
                        //             foregroundColor: Colors.white,
                        //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.w)),
                        //           ),
                        //           label: Text("Sync Location", style: TextStyle(fontSize: 10.sp), maxLines: 1),
                        //           icon: Icon(Icons.refresh),
                        //           iconAlignment: IconAlignment.end,
                        //         ),
                        //         SizedBox(height: 4.h),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // Text("Your")
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _informationAttendance(
                                title: "Check In",
                                time: homeProv.checkIn.substring(0, 5),
                                colorIcon: Colors.green,
                                colorBackground: Colors.green.shade50,
                              ),

                              SizedBox(width: 24.w),

                              _informationAttendance(
                                title: "Check Out",
                                time: homeProv.checkOut.substring(0, 5),
                                colorIcon: Colors.red,
                                colorBackground: Colors.red.shade50,
                              ),
                            ],
                          ),
                        ),

                        Divider(thickness: 1, color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),

                        Visibility(
                          visible: homeProv.shiftUserModel!.shiftName!.isEmpty ? false : true,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Row(
                              spacing: 16.w,
                              children: [
                                _buttonAttendance(
                                  title: "Check In",
                                  icon: Icons.arrow_circle_down,
                                  background: Colors.green,
                                  iconAlignment: IconAlignment.end,
                                  onPressed: homeProv.checkIn == "00:00"
                                      ? () async {
                                          DialogHelper.showLoadingDialog(context, message: "Loading validate location...");
                                          final checkAttendance = await homeProv.fetchCurrentLocation(provPref.configModel!);

                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                          if (checkAttendance) {
                                            DialogHelper.showInfoDialog(
                                              context,
                                              icon: Icon(Icons.info_outline, size: 32, color: Colors.blue),
                                              title: "Attendance",
                                              message: homeProv.message,
                                              confirmText: "Next",
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                await availableCameras().then(
                                                  (value) =>
                                                      Navigator.pushNamed(context, Routes.cameraScreen, arguments: {'location': 1, 'cameras': value}),
                                                );
                                              },
                                            );
                                          } else {
                                            DialogHelper.showInfoDialog(
                                              context,
                                              icon: Icon(Iconsax.close_circle_outline, size: 32, color: Colors.red),
                                              title: "Attendance",
                                              message: homeProv.message,
                                              onPressed: () async {
                                                Navigator.pop(context);
                                              },
                                            );
                                          }
                                        }
                                      : null,
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
                                  onPressed: homeProv.checkIn != "00:00" && homeProv.checkOut == "00:00"
                                      ? () async {
                                          DialogHelper.showLoadingDialog(context, message: "Loading validate location...");
                                          final checkAttendance = await homeProv.fetchCurrentLocation(provPref.configModel!);

                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                          if (checkAttendance) {
                                            DialogHelper.showInfoDialog(
                                              context,
                                              icon: Icon(Icons.info_outline, size: 32, color: Colors.blue),
                                              title: "Attendance",
                                              message: homeProv.message,
                                              confirmText: "Next",
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                await availableCameras().then(
                                                  (value) =>
                                                      Navigator.pushNamed(context, Routes.cameraScreen, arguments: {'location': 2, 'cameras': value}),
                                                );
                                              },
                                            );
                                          } else {
                                            DialogHelper.showInfoDialog(
                                              context,
                                              icon: Icon(Iconsax.close_circle_outline, size: 32, color: Colors.red),
                                              title: "Attendance",
                                              message: homeProv.message,
                                              onPressed: () async {
                                                Navigator.pop(context);
                                              },
                                            );
                                          }
                                        }
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }

  Widget _informationAttendance({required String title, required String time, required Color colorIcon, required Color colorBackground}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                    title,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10.sp),
                  ),
                  Text(
                    time,
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
        onPressed: onPressed,
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

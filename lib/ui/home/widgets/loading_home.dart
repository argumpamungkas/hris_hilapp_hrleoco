import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../providers/home_provider.dart';
import '../../../providers/notifications/notification_provider.dart';
import '../../../providers/preferences_provider.dart';
import 'background_home.dart';
import 'notification_widget.dart';

class LoadingHome extends StatelessWidget {
  const LoadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, PreferencesProvider>(
      builder: (context, provHome, provPref, _) {
        return RefreshIndicator(
          onRefresh: () async {
            // provHome.fetchHome();
            Provider.of<NotificationProvider>(context, listen: false).fetchNotification();
            // Provider.of<AttendanceTeamController>(context, listen: false).fetchDaysOff();
            // Provider.of<NewsController>(context, listen: false).fetchNews(context);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    provPref.isDarkTheme ? Container() : const BackgroundHome(),
                    SafeArea(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          const NotificationWidget(),
                          SizedBox(height: 8.h),
                          _loadingUser(provPref),
                          SizedBox(height: 8.h),
                          _loadingBox(height: 120.h, prov: provPref),
                          SizedBox(height: 8.h),
                          _loadingBox(height: 150.h, prov: provPref),
                          SizedBox(height: 16.h),
                          _loadingAttendanceSummary(prov: provPref),
                          SizedBox(height: 16.h),
                          _loadingBox(height: 100.h, prov: provPref),
                          SizedBox(height: 8.h),
                          _loadingBox(height: 100.h, prov: provPref),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _loadingUser(PreferencesProvider prov) {
  return SizedBox(
    child: Shimmer.fromColors(
      baseColor: prov.isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade300,
      highlightColor: prov.isDarkTheme ? Colors.black : Colors.white,
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.h,
            margin: EdgeInsets.only(right: 16.w),
            decoration: BoxDecoration(color: prov.isDarkTheme ? Colors.black : Colors.white, shape: BoxShape.circle),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 10.h, width: 100.h, color: prov.isDarkTheme ? Colors.black : Colors.white),
              SizedBox(height: 8.h),
              Container(height: 10.h, width: 100.h, color: prov.isDarkTheme ? Colors.black : Colors.white),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _loadingBox({required double height, required PreferencesProvider prov}) {
  return Shimmer.fromColors(
    baseColor: prov.isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade300,
    highlightColor: prov.isDarkTheme ? Colors.black : Colors.white,
    child: Card(
      color: prov.isDarkTheme ? Colors.black : Colors.white,
      child: Container(height: height),
    ),
  );
}

Widget _loadingAttendanceSummary({required PreferencesProvider prov}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Shimmer.fromColors(
        baseColor: prov.isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade300,
        highlightColor: prov.isDarkTheme ? Colors.black : Colors.white,
        child: Container(
          height: 150.h,
          width: 150.w,
          decoration: BoxDecoration(color: prov.isDarkTheme ? Colors.black : Colors.white, shape: BoxShape.circle),
        ),
      ),
      Shimmer.fromColors(
        baseColor: prov.isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade300,
        highlightColor: prov.isDarkTheme ? Colors.black : Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.h),
              height: 16.h,
              width: 16.w,
              decoration: BoxDecoration(color: prov.isDarkTheme ? Colors.black : Colors.white, shape: BoxShape.circle),
            ),
            SizedBox(height: 4.h),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.h),
              height: 16.h,
              width: 16.w,
              decoration: BoxDecoration(color: prov.isDarkTheme ? Colors.black : Colors.white, shape: BoxShape.circle),
            ),
            SizedBox(height: 4.h),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.h),
              height: 16.h,
              width: 16.w,
              decoration: BoxDecoration(color: prov.isDarkTheme ? Colors.black : Colors.white, shape: BoxShape.circle),
            ),
            SizedBox(height: 4.h),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.h),
              height: 16.h,
              width: 16.w,
              decoration: BoxDecoration(color: prov.isDarkTheme ? Colors.black : Colors.white, shape: BoxShape.circle),
            ),
          ],
        ),
      ),
    ],
  );
}

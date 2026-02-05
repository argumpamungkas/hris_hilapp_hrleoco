import 'package:animate_do/animate_do.dart';
import 'package:easy_hris/ui/home/widgets/announcement_container.dart';
import 'package:easy_hris/ui/home/widgets/attendance_summary.dart';
import 'package:easy_hris/ui/home/widgets/attendance_widget.dart';
import 'package:easy_hris/ui/util/widgets/background_home.dart';
import 'package:easy_hris/ui/home/widgets/container_history_attendance.dart';
import 'package:easy_hris/ui/home/widgets/menu_home.dart';
import 'package:easy_hris/ui/home/widgets/notification_widget.dart';
import 'package:easy_hris/ui/home/widgets/permission_container.dart';
import 'package:easy_hris/ui/home/widgets/user_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../providers/home_provider.dart';
import '../../providers/notifications/notification_provider.dart';
import '../../providers/preferences_provider.dart';
import '../util/widgets/card_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<NotificationProvider>(context, listen: false).fetchNotification();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(Provider.of<PreferencesProvider>(context, listen: false).configModel!),
      child: Scaffold(
        body: Consumer2<HomeProvider, PreferencesProvider>(
          builder: (context, provHome, provPref, _) {
            switch (provHome.resultStatus) {
              case ResultStatus.loading:
                return SizedBox();
              case ResultStatus.error:
                return FadeInUp(
                  child: Center(
                    child: CardInfo(
                      iconData: Iconsax.info_circle_outline,
                      colorIcon: Colors.red,
                      title: "Error",
                      description: provHome.message,
                      onPressed: () {
                        provHome.init();
                        provHome.fetchCurrentLocation(provPref.configModel!);
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
                    provHome.fetching(provPref.configModel!);
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Stack(
                      children: [
                        provPref.isDarkTheme ? Container() : const BackgroundHome(),
                        SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // jangan lupa update version disini
                              const NotificationWidget(),
                              SizedBox(height: 12.h),
                              UserWidget(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
                                ),
                                child: Column(
                                  spacing: 8.h,
                                  children: [
                                    MenuHome(),
                                    AttendanceWidget(),
                                    ContainerHistoryAttendance(),
                                    AttendanceSummaryContainer(),
                                    PermissionContainer(),
                                    AnnouncementContainer(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

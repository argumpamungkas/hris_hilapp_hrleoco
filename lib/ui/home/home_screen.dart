import 'package:animate_do/animate_do.dart';
import 'package:easy_hris/ui/home/widgets/attendance_summary.dart';
import 'package:easy_hris/ui/home/widgets/attendance_widget.dart';
import 'package:easy_hris/ui/home/widgets/background_home.dart';
import 'package:easy_hris/ui/home/widgets/container_user_action.dart';
import 'package:easy_hris/ui/home/widgets/list_view_days_off.dart';
import 'package:easy_hris/ui/home/widgets/list_view_latest_news.dart';
import 'package:easy_hris/ui/home/widgets/loading_home.dart';
import 'package:easy_hris/ui/home/widgets/menu_home.dart';
import 'package:easy_hris/ui/home/widgets/notification_widget.dart';
import 'package:easy_hris/ui/home/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../providers/auth/profile_provider.dart';
import '../../providers/home_provider.dart';
import '../../providers/notifications/notification_provider.dart';
import '../../providers/preferences_provider.dart';
import '../attendance_team/controller/day_off_controller.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NotificationProvider>(context, listen: false).fetchNotification();
    });
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
                return const LoadingHome();
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
                    provHome.init();
                    provHome.fetchCurrentLocation(provPref.configModel!);
                  },
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        provPref.isDarkTheme ? Container() : const BackgroundHome(),
                        SafeArea(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // jangan lupa update version disini
                                const NotificationWidget(),
                                SizedBox(height: 12.h),
                                ContainerUserAction(),
                                AttendanceWidget(),
                                SizedBox(height: 8.h),
                                AttendanceSummaryContainer(),
                                // const MenuHome(),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     SizedBox(height: 4.h),
                                //     AttendanceWidget(),
                                //     SizedBox(height: 10.h),
                                //     const AttendanceSummaryContainer(),
                                //     //  Ceking dayoff (attendance Team)
                                //     Consumer<ProfileProvider>(
                                //       builder: (context, prov, _) {
                                //         switch (prov.resultStatus) {
                                //           case ResultStatus.loading:
                                //             return Container();
                                //           case ResultStatus.hasData:
                                //             return Visibility(
                                //               visible: prov.userProfile!.access == "LIMITED" ? false : true,
                                //               child: Container(
                                //                 margin: EdgeInsets.only(top: 10.h),
                                //                 child: ListViewAttendanceTeam(access: prov.userProfile!.access!),
                                //               ),
                                //             );
                                //           default:
                                //             return Container();
                                //         }
                                //       },
                                //     ),
                                //     const SizedBox(height: 16),
                                //     const ListViewLatestNews(),
                                //     const SizedBox(height: 16),
                                //   ],
                                // ),
                              ],
                            ),
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

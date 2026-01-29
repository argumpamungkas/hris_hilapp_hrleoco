import 'package:animate_do/animate_do.dart';
import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/ui/util/widgets/dialog_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../constant/exports.dart';
import '../../providers/auth/profile_provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/preferences_provider.dart';
import '../util/widgets/card_info.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provPref = Provider.of<ProfileProvider>(context, listen: false);

      if (provPref.userModel == null) {
        provPref.getUser();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => DashboardProvider())],
      child: Consumer2<PreferencesProvider, DashboardProvider>(
        builder: (context, prefProv, provDashboard, _) {
          return WillPopScope(
            onWillPop: () async {
              if (provDashboard.currentIndex == 0) {
                return true;
              } else {
                provDashboard.changeScreen(0);
                return false;
              }
            },
            child: Scaffold(
              backgroundColor: prefProv.isDarkTheme ? Colors.black : Colors.grey.shade50,
              body: Consumer2<DashboardProvider, ProfileProvider>(
                builder: (context, prov, provProfile, _) {
                  switch (provProfile.resultStatusUserModel) {
                    case ResultStatus.loading:
                      return Center(child: CircularProgressIndicator());
                    case ResultStatus.error:
                      return FadeInUp(
                        child: Center(
                          child: CardInfo(
                            iconData: Iconsax.info_circle_outline,
                            colorIcon: Colors.red,
                            title: "Error",
                            description: provProfile.message,
                            onPressed: () {
                              provProfile.getUser();
                            },
                            titleButton: "Refresh",
                            colorTitle: Colors.red,
                            buttonStyle: ElevatedButton.styleFrom(backgroundColor: ConstantColor.colorBlueDark, foregroundColor: Colors.white),
                          ),
                        ),
                      );
                    case ResultStatus.noData:
                      return FadeInUp(
                        child: Center(
                          child: CardInfo(
                            iconData: Iconsax.info_circle_outline,
                            colorIcon: Colors.red,
                            title: "Employee",
                            description: provProfile.message,
                            onPressed: () {
                              provProfile.onClearPrefs();
                              Navigator.pushNamedAndRemoveUntil(context, Routes.signInScreen, (route) => false);
                            },
                            titleButton: "Re-Login",
                            colorTitle: Colors.red,
                            buttonStyle: ElevatedButton.styleFrom(backgroundColor: ConstantColor.colorBlueDark, foregroundColor: Colors.white),
                          ),
                        ),
                      );
                    case ResultStatus.hasData:
                      if (provProfile.isActive == '0') {
                        return prov.widgetScreenLead[prov.currentIndex];
                      } else {
                        return FadeInUp(
                          child: Center(
                            child: CardInfo(
                              iconData: Iconsax.info_circle_outline,
                              colorIcon: Colors.red,
                              title: "Employee",
                              description: provProfile.message,
                              onPressed: () {
                                provProfile.onClearPrefs();
                                Navigator.pushNamedAndRemoveUntil(context, Routes.signInScreen, (route) => false);
                              },
                              titleButton: "Re-Login",
                              colorTitle: Colors.red,
                              buttonStyle: ElevatedButton.styleFrom(backgroundColor: ConstantColor.colorBlueDark, foregroundColor: Colors.white),
                            ),
                          ),
                        );
                      }

                    default:
                      return FadeInUp(
                        child: Center(
                          child: CardInfo(
                            iconData: Iconsax.info_circle_outline,
                            colorIcon: Colors.red,
                            title: "404",
                            description: "Something wrong.",
                            onPressed: () {
                              provProfile.onClearPrefs();
                              Navigator.pushNamedAndRemoveUntil(context, Routes.signInScreen, (route) => false);
                            },
                            titleButton: "Re-Login",
                            colorTitle: Colors.red,
                            buttonStyle: ElevatedButton.styleFrom(backgroundColor: ConstantColor.colorBlueDark, foregroundColor: Colors.white),
                          ),
                        ),
                      );
                  }
                },
              ),
              bottomNavigationBar: Consumer3<DashboardProvider, ProfileProvider, PreferencesProvider>(
                builder: (context, provDashboard, provProfile, prefProv, _) {
                  if (provProfile.resultStatusUserModel == ResultStatus.hasData) {
                    return Theme(
                      data: Theme.of(context).copyWith(canvasColor: prefProv.isDarkTheme ? Colors.black : Colors.white),
                      child: BottomNavigationBar(
                        items: provDashboard.bottomNavBarLead,
                        currentIndex: provDashboard.currentIndex,
                        onTap: provDashboard.changeScreen,
                        selectedFontSize: 9.sp,
                        selectedIconTheme: IconThemeData(size: 16.w.h),
                        unselectedFontSize: 9.sp,
                        unselectedIconTheme: IconThemeData(size: 16.w.h),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

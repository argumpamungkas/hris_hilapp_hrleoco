import 'package:easy_hris/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/exports.dart';
import '../../providers/auth/profile_provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/preferences_provider.dart';

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
      child: Consumer<PreferencesProvider>(
        builder: (context, prefProv, _) {
          return Scaffold(
            backgroundColor: prefProv.isDarkTheme ? Colors.black : Colors.grey.shade50,
            body: Consumer2<DashboardProvider, ProfileProvider>(
              builder: (context, prov, provPref, _) {
                if (provPref.resultStatusUserModel == ResultStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return prov.widgetScreenLead[prov.currentIndex];
                }
              },
            ),
            bottomNavigationBar: Consumer3<DashboardProvider, ProfileProvider, PreferencesProvider>(
              builder: (context, provDashboard, provProfile, prefProv, _) {
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
              },
            ),
          );
        },
      ),
    );
  }
}

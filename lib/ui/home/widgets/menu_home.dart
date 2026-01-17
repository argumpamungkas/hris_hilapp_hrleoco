import 'package:easy_hris/data/models/employee_model.dart';
import 'package:easy_hris/ui/home/widgets/user_widget.dart';
import 'package:easy_hris/ui/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../constant/exports.dart';
import '../../../constant/routes.dart';
import '../../../providers/auth/profile_provider.dart';
import '../../../providers/preferences_provider.dart';
import '../../attendance/attendance_screen.dart';
import '../../change_day/change_day_screen.dart';
import '../../pay_slip_page/pay_slip/pay_slip_screen.dart';

class MenuHome extends StatelessWidget {
  const MenuHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<PreferencesProvider, ProfileProvider>(
      builder: (context, provPref, provProf, _) {
        return Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  itemMenu(
                    context,
                    onTap: () => Navigator.pushNamed(context, Routes.employeeScreen),
                    // assetImage: "assets/images/employee_icon.png",
                    icon: Icons.person_2_outlined,
                    backgroundIcon: Colors.purple.shade200,
                    titleMenu: "Employee",
                    colorText: provPref.isDarkTheme ? Colors.white : Colors.grey,
                  ),
                  // SizedBox(width: 8),
                  itemMenu(
                    context,
                    // onTap: () => Navigator.pushNamed(context, Routes.overtimeScreen),
                    onTap: () => showInfoSnackbar(context, "Feature on Progress"),
                    // assetImage: "assets/images/clock.png",
                    icon: Icons.timelapse,
                    backgroundIcon: Colors.teal.shade200,
                    titleMenu: "Overtime",
                    colorText: provPref.isDarkTheme ? Colors.white : Colors.grey,
                  ),
                  // SizedBox(width: 8),
                  itemMenu(
                    context,
                    // onTap: () => Navigator.pushNamed(context, ChangeDayScreen.routeName),
                    onTap: () => showInfoSnackbar(context, "Feature on Progress"),
                    // assetImage: "assets/images/timetable.png",
                    icon: Icons.edit_calendar,
                    backgroundIcon: Colors.pinkAccent.shade200,
                    titleMenu: "Change Day",
                    colorText: provPref.isDarkTheme ? Colors.white : Colors.grey,
                  ),
                  // SizedBox(width: 8),
                  itemMenu(
                    context,
                    // onTap: () => Navigator.pushNamed(context, Routes.permitScreen),
                    onTap: () => showInfoSnackbar(context, "Feature on Progress"),
                    // assetImage: "assets/images/pen.png",
                    icon: Icons.person_pin_outlined,
                    backgroundIcon: Colors.red.shade200,
                    titleMenu: "Permit",
                    colorText: provPref.isDarkTheme ? Colors.white : Colors.grey,
                  ),
                  // SizedBox(width: 8),
                  itemMenu(
                    context,
                    // onTap: () => Navigator.pushNamed(context, PaySlipScreen.routeName),
                    onTap: () => showInfoSnackbar(context, "Feature on Progress"),
                    icon: Icons.payment_sharp,
                    backgroundIcon: Colors.blueAccent.shade200,
                    // assetImage: "assets/images/salary.png",
                    titleMenu: "Pay Slip",
                    colorText: provPref.isDarkTheme ? Colors.white : Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget itemMenu(
    BuildContext context, {
    required void Function()? onTap,
    // required String assetImage,
    // required String assetImage,
    required String titleMenu,
    required Color colorText,
    required Color backgroundIcon,
    required IconData icon,
  }) {
    return Container(
      // color: Colors.amber,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      width: 0.15.sw,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            // ColorFiltered(
            //   colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.dst),
            //   child: Image.asset(assetImage, width: 36.w),
            // ),
            Consumer<PreferencesProvider>(
              builder: (context, prov, _) {
                return Card(
                  surfaceTintColor: backgroundIcon,
                  color: backgroundIcon,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(50)),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Icon(icon, color: Colors.white),
                  ),
                );
              },
            ),
            SizedBox(height: 8.h),
            Text(
              titleMenu,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colorText, fontWeight: FontWeight.bold, fontSize: 8.sp),
            ),
          ],
        ),
      ),
    );
  }
}

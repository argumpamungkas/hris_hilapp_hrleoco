import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/ui/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../constant/exports.dart';
import '../../../constant/routes.dart';
import '../../../providers/auth/profile_provider.dart';
import '../../../providers/preferences_provider.dart';
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
                    icon: Icons.person,
                    titleMenu: "Employee",
                  ),
                  // SizedBox(width: 8),
                  itemMenu(
                    context,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.overtimeScreen);
                    },
                    icon: Icons.access_time_filled_sharp,
                    titleMenu: "Overtime",
                  ),
                  // SizedBox(width: 8),
                  itemMenu(
                    context,
                    // onTap: () => Navigator.pushNamed(context, ChangeDayScreen.routeName),
                    onTap: () => showInfoSnackbar(context, "Feature on Progress"),
                    // assetImage: "assets/images/timetable.png",
                    icon: Iconsax.calendar_bold,
                    titleMenu: "Change Day",
                  ),
                  // SizedBox(width: 8),
                  itemMenu(
                    context,
                    // onTap: () => Navigator.pushNamed(context, Routes.permitScreen),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.permitScreen);
                    },
                    // assetImage: "assets/images/pen.png",
                    icon: Iconsax.logout_1_outline,
                    titleMenu: "Permit",
                  ),
                  // SizedBox(width: 8),
                  itemMenu(
                    context,
                    onTap: () => Navigator.pushNamed(context, PaySlipScreen.routeName),
                    // onTap: () => showInfoSnackbar(context, "Feature on Progress"),
                    icon: Iconsax.card_bold,
                    titleMenu: "Pay Slip",
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget itemMenu(BuildContext context, {required void Function()? onTap, required String titleMenu, required IconData icon}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      width: 0.15.sw,
      child: InkWell(
        onTap: onTap,
        child: Consumer<PreferencesProvider>(
          builder: (context, prov, _) {
            return Column(
              spacing: 4.h,
              children: [
                Card(
                  surfaceTintColor: ConstantColor.colorBlue,
                  color: ConstantColor.colorBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(50.w)),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Icon(icon, color: Colors.white),
                  ),
                ),
                Text(
                  titleMenu,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: prov.isDarkTheme ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 8.sp),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

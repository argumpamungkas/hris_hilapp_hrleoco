import 'package:easy_hris/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/exports.dart';
import '../../../providers/preferences_provider.dart';

class CardHomeCustom extends StatelessWidget {
  const CardHomeCustom({super.key, required this.title, required this.subtitle, this.widget});

  final String title, subtitle;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provPref, _) {
        return Card(
          surfaceTintColor: provPref.isDarkTheme ? Colors.black : Colors.white,
          color: provPref.isDarkTheme ? Colors.black : Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
            side: BorderSide(color: provPref.isDarkTheme ? ConstantColor.colorBlueDark : Colors.grey.shade300),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(color: provPref.isDarkTheme ? Colors.black : Colors.white, borderRadius: BorderRadius.circular(16.w)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    height: 0,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: provPref.isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(height: 0, fontSize: 11.sp, color: provPref.isDarkTheme ? Colors.white : Colors.black),
                ),
                SizedBox(height: 8.h),
                ?widget,
              ],
            ),
          ),
        );
      },
    );
  }
}

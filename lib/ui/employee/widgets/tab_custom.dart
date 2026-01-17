import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';

class TabCustom extends StatelessWidget {
  const TabCustom({super.key, required this.isNowTab, required this.title, required this.onTap});

  final bool isNowTab;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Consumer<PreferencesProvider>(
        builder: (context, prov, _) {
          return Container(
            decoration: BoxDecoration(
              color: isNowTab
                  ? colorPurpleAccent
                  : prov.isDarkTheme
                  ? Colors.black
                  : Colors.white,
              // borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorPurpleAccent, width: 1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            width: 0.3.sw,
            child: Text(
              title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: isNowTab
                    ? Colors.white
                    : prov.isDarkTheme
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}

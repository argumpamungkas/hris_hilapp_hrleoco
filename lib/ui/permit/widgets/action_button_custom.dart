import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionButtonCustom extends StatelessWidget {
  const ActionButtonCustom({super.key, required this.onTap, required this.iconData});

  final void Function()? onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: prov.isDarkTheme ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(8.w),
              border: Border.all(color: prov.isDarkTheme ? ConstantColor.colorBlue : Colors.transparent),
            ),
            child: Icon(iconData, size: 20.sp, color: prov.isDarkTheme ? Colors.white : Colors.black),
          ),
        );
      },
    );
  }
}

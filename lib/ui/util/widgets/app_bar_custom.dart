import 'package:easy_hris/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class AppbarCustom {
  static AppBar appbar(BuildContext context, {required String title, required bool leadingBack, List<Widget>? action}) {
    return AppBar(
      title: Text(title, overflow: TextOverflow.ellipsis),
      titleTextStyle: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w700),
      backgroundColor: ConstantColor.colorBlue,
      foregroundColor: Colors.white,
      leading: leadingBack
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            )
          : const SizedBox.shrink(),
      actions: action,
    );
  }
}

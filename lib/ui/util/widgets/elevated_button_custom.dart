import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';

class ElevatedButtonCustom extends StatelessWidget {
  const ElevatedButtonCustom({super.key, required this.onPressed, required this.title, this.backgroundColor = colorBlueDark});

  final void Function()? onPressed;
  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size.fromHeight(36.h),
      ),
      child: Text(title),
    );
  }
}

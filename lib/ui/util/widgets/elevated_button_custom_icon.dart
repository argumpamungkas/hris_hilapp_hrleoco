import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';

class ElevatedButtonCustomIcon extends StatelessWidget {
  const ElevatedButtonCustomIcon({super.key, required this.onPressed, required this.title, this.backgroundColor});

  final void Function()? onPressed;
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ConstantColor.colorBlue,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size.fromHeight(36.h),
      ),
      label: Text(title),
      icon: Icon(Icons.check_box_rounded),
    );
  }
}

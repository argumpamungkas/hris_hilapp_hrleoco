import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemInfoAttendance extends StatelessWidget {
  const ItemInfoAttendance({super.key, required this.info, required this.color});

  final String info;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Text(
        info,
        style: TextStyle(color: Colors.white, fontSize: 10.sp),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemInfoAttendance extends StatelessWidget {
  const ItemInfoAttendance({
    super.key,
    required this.info,
    required this.total,
    required this.color,
  });

  final String info;
  final int total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        "$info: $total",
        style: TextStyle(
          color: Colors.white,
          fontSize: 7.sp,
        ),
      ),
    );
  }
}

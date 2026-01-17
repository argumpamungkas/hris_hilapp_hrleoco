import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataEmpty extends StatelessWidget {
  const DataEmpty({
    super.key,
    required this.dataName,
  });

  final String dataName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        margin: EdgeInsets.symmetric(vertical: 8.w),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "$dataName is Empty",
          textAlign: TextAlign.center,
          softWrap: true,
          style: TextStyle(
            color: Colors.red.shade800,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}

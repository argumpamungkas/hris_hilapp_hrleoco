import 'package:easy_hris/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataEmpty extends StatelessWidget {
  const DataEmpty({super.key, required this.dataName});

  final String dataName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(vertical: 8.w),
        decoration: BoxDecoration(color: ConstantColor.bgIcon, borderRadius: BorderRadius.circular(8)),
        child: Column(
          spacing: 4.h,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.info_outline, size: 32.w),
            Text(
              "$dataName is Empty",
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(color: Colors.black, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}

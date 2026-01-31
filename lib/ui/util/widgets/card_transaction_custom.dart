import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';

class CardTransactionCustom extends StatelessWidget {
  const CardTransactionCustom({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.approval,
    required this.onTap,
  });

  final String title, subtitle, status, approval;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(color: ConstantColor.bgIcon, borderRadius: BorderRadius.circular(8.w)),
              child: Icon(Icons.file_present_outlined),
            ),
            title: Column(
              spacing: 3.h,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 10.sp, color: Colors.black, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            // subtitle: Text("30 December 2026"),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  status,
                  style: TextStyle(fontSize: 12.sp, color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Text(
                  approval,
                  style: TextStyle(fontSize: 10.sp, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';

class CardItemTransaction extends StatelessWidget {
  const CardItemTransaction({super.key, required this.title, required this.subtitle, this.trailing});

  final String title, subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
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
        trailing: trailing,
      ),
    );
  }
}

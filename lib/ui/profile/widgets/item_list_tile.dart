import 'package:easy_hris/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({super.key, required this.iconLeading, required this.title, required this.onTap});

  final IconData iconLeading;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        onTap: onTap,
        leading: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(color: ConstantColor.bgIcon, borderRadius: BorderRadius.circular(8.w)),
          child: Icon(iconLeading, color: Colors.black),
        ),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        trailing: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade200),
          child: Icon(Icons.arrow_forward_ios, size: 14.w),
        ),
      ),
    );
  }
}

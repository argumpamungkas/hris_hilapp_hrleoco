import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';

class CardCustomIcon extends StatelessWidget {
  const CardCustomIcon({super.key, required this.title, required this.subtitle, required this.iconData, this.trailing});

  final String title, subtitle;
  final IconData? iconData;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(shape: BoxShape.circle, color: ConstantColor.colorBlue),
          child: Icon(iconData, color: Colors.white),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.normal),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        trailing: trailing,
      ),
    );
  }
}

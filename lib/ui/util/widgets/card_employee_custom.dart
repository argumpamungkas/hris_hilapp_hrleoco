import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'image_network_custom.dart';

class CardEmployeeCustom extends StatelessWidget {
  const CardEmployeeCustom({super.key, required this.imageUrl, required this.title, required this.subtitle, this.trailing});

  final String imageUrl, title, subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      children: [
        SizedBox(
          height: 32.h,
          width: 32.w,
          child: ClipOval(child: ImageNetworkCustom(isFit: true, url: imageUrl)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
              Text(subtitle, style: TextStyle(fontSize: 11.sp)),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

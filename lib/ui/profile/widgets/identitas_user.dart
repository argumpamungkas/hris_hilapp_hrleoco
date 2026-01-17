import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../providers/preferences_provider.dart';

class IdentityUser extends StatelessWidget {
  const IdentityUser({super.key, required this.imageUrl, required this.name, required this.position});

  final String imageUrl, name, position;
  // final String imageUrl, name, position, service;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                height: 80.h,
                width: 80.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover, filterQuality: FilterQuality.medium),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                name,
                style: TextStyle(fontSize: 16.sp, color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700, fontWeight: FontWeight.bold),
              ),
              Text(
                position,
                style: TextStyle(color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700, fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
              SizedBox(height: 4.h),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              //   decoration: BoxDecoration(color: colorPurpleAccent, borderRadius: BorderRadius.circular(50)),
              //   child: Text(
              //     service,
              //     style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.bold, color: Colors.white),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}

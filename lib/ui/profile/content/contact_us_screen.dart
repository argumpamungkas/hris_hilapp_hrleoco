import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: ExpansionTile(
              shape: const Border(), // saat expanded
              collapsedShape: const Border(), // saat collapsed
              tilePadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              title: Text(
                "Contact Us",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              childrenPadding: EdgeInsets.symmetric(horizontal: 8.w),
              children: [
                Text("Only people who are registered as employees of the company can register an account to login in the GreatTalent"),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

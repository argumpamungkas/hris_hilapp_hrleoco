import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/preferences_provider.dart';

class ItemAttendanceHistory extends StatelessWidget {
  const ItemAttendanceHistory({super.key, required this.day, required this.month, required this.year, required this.timeIn, required this.timeOut});

  final String day;
  final String month;
  final String year;
  final String timeIn;
  final String timeOut;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Card(
          child: ListTile(
            leading: Text(
              day,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
            horizontalTitleGap: 2.w,
            title: Text(
              month,
              // style: TextStyle(
              //   color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700,
              //   fontSize: 14.sp,
              // ),
            ),
            subtitle: Text(
              year,
              // style: TextStyle(
              //   fontSize: 14.sp,
              //   color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700,
              // ),
            ),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  height: 20.h,
                  decoration: BoxDecoration(color: Colors.green.shade300, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    timeIn,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 8.sp),
                  ),
                ),
                SizedBox(width: 4.w),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  height: 20.h,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    timeOut,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 8.sp),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

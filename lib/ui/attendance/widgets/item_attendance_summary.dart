import 'package:easy_hris/data/models/response/attendance_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/preferences_provider.dart';

class ItemAttendanceSummary extends StatelessWidget {
  const ItemAttendanceSummary({super.key, required this.items, required this.colorStatus});

  final DetailAttendanceSummary items;
  final Color colorStatus;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Card(
          child: ListTile(
            title: Text(items.transDate!, style: TextStyle(fontSize: 13.sp)),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Row(
                spacing: 10.w,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time_rounded, size: 14.h.w, color: Colors.green),
                      SizedBox(width: 4.h),
                      Text(items.checkIn!.isNotEmpty ? items.checkIn! : "-"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time_rounded, size: 14.h.w, color: Colors.red),
                      SizedBox(width: 4.h),
                      Text(items.checkOut!.isNotEmpty ? items.checkOut! : "-"),
                    ],
                  ),
                ],
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(4),
              width: 0.3.sw,
              decoration: BoxDecoration(color: colorStatus, borderRadius: BorderRadius.circular(8)),
              child: Text(
                items.status!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}

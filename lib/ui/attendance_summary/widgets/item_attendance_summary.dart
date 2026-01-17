import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/models/attendance_summary.dart';
import '../../../providers/preferences_provider.dart';

class ItemAttendanceSummary extends StatelessWidget {
  const ItemAttendanceSummary({super.key, required this.items, required this.date, required this.colorStatus});

  final ResultAttendanceSummary items;
  final String date;
  final Color colorStatus;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Card(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            tileColor: items.status == "NOT YET"
                ? Colors.grey.shade300
                : items.status == "HOLIDAY" || items.status == "WEEKEND"
                ? Colors.red.shade300
                : Colors.transparent,
            title: Text(
              date,
              style: TextStyle(
                color: items.status == "HOLIDAY" || items.status == "WEEKEND"
                    ? Colors.white
                    : prov.isDarkTheme
                    ? Colors.white
                    : Colors.grey.shade700,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                items.color.toUpperCase() == "GREEN" || items.color.toUpperCase() == "ORANGE"
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.access_time_rounded, size: 14.h.w, color: Colors.green),
                                    SizedBox(width: 4.h),
                                    Text(items.timeIn != null || items.timeIn! != "" ? items.timeIn! : "-"),
                                  ],
                                ),
                                SizedBox(width: 4.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.access_time_rounded, size: 14.h.w, color: Colors.red),
                                    SizedBox(width: 4.h),
                                    Text(items.timeOut != null || items.timeOut! != "" ? items.timeOut! : "-"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),
                items.color.toUpperCase() == "GREEN" || items.color.toUpperCase() == "ORANGE"
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.h),
                          Text(
                            items.remarks == '' || items.remarks!.isEmpty ? "Remarks: -" : "Remarks: ${items.remarks}",
                            style: TextStyle(
                              color: items.status == "HOLIDAY" || items.status == "WEEKEND"
                                  ? Colors.white
                                  : prov.isDarkTheme
                                  ? Colors.white
                                  : Colors.grey.shade700,
                              fontSize: 8.sp,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: colorStatus, borderRadius: BorderRadius.circular(8)),
              child: Text(items.status, style: const TextStyle(color: Colors.white, fontSize: 8)),
            ),
          ),
        );
      },
    );
  }
}

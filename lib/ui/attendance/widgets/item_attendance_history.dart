import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/data/models/response/attendance_model.dart';
import 'package:easy_hris/ui/util/widgets/image_network_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class ItemAttendanceHistory extends StatelessWidget {
  const ItemAttendanceHistory({super.key, required this.item, required this.baseUrl});

  final AttendanceModel item;
  final String baseUrl;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd').parse(item.transDate!);
    final date = DateFormat('EE, dd MMM yyyy').format(dateFormat);

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                children: [
                  Expanded(child: Text(item.location == '1' ? "Shift Start" : "Shift End")),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Iconsax.close_circle_outline),
                  ),
                ],
              ),
              content: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 0.7.sh),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 8.h,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ImageNetworkCustom(url: "$baseUrl/${Constant.urlAttendance}/${item.foto}"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4.h,
                        children: [
                          Text("Information Attendance :", style: TextStyle(fontWeight: FontWeight.w700)),
                          Text('Date : $date'),
                          Text('Time : ${item.transTime?.substring(0, 5) ?? "00:00"}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          child: Row(
            spacing: 10.w,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: item.location == '1' ? Colors.green.shade100 : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: item.location == '1'
                    ? Icon(FontAwesome.arrow_up_right_from_square_solid, size: 16.w, color: Colors.green)
                    : RotatedBox(
                        quarterTurns: 2,
                        child: Icon(FontAwesome.arrow_up_right_from_square_solid, size: 16.w, color: Colors.red),
                      ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // main
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            item.location == "1" ? "Start Shift" : "End Shift",
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            date,
                            style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    // Prefix
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.transTime?.substring(0, 5) ?? "00:00",
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item.result ?? "",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: item.result!.toUpperCase().contains("LATE")
                                ? Colors.red
                                : item.result!.toUpperCase().contains("OVERTIME")
                                ? Colors.blue
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

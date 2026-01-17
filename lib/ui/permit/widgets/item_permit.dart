import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/routes.dart';
import '../../../data/models/permit.dart';

class ItemPermit extends StatelessWidget {
  const ItemPermit({super.key, required this.resultPermit, required this.permitDate});

  final ResultPermit resultPermit;
  final String permitDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            onTap: () => Navigator.pushNamed(context, Routes.permitDetailScreen, arguments: resultPermit),
            title: Text(permitDate.isNotEmpty ? permitDate : "-", maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(resultPermit.permitTypeName!, maxLines: 1, overflow: TextOverflow.ellipsis),
            contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            trailing: Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: resultPermit.disapprovedBy != null
                    ? Colors.red
                    : resultPermit.approvedTo == null || resultPermit.approvedTo == ""
                    ? Colors.green.shade300
                    : Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                resultPermit.disapprovedBy != null
                    ? "Disapproved"
                    : resultPermit.approvedTo == null || resultPermit.approvedTo == ""
                    ? "Approved"
                    : "Checking",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 7.sp),
              ),
            ),
          ),
        ),
        // Divider(
        //   thickness: 1,
        //   height: 0,
        //   color: Colors.grey.shade300,
        // ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/routes.dart';
import '../../../data/models/overtime.dart';

class ItemOvertime extends StatelessWidget {
  const ItemOvertime({
    super.key,
    required this.resultOvertime,
    required this.overtimeDate,
  });

  final ResultsOvertime resultOvertime;
  final String overtimeDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            onTap: () => Navigator.pushNamed(
              context,
              Routes.overtimeDetailScreen,
              arguments: resultOvertime,
            ),
            title: Text(
              overtimeDate.isNotEmpty ? overtimeDate : '-',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              resultOvertime.requestCode != null
                  ? resultOvertime.requestCode!
                  : "-",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            trailing: Container(
              padding: EdgeInsets.symmetric(
                vertical: 4.h,
                horizontal: 8.w,
              ),
              decoration: BoxDecoration(
                color: resultOvertime.disapprovedBy != null
                    ? Colors.red
                    : resultOvertime.approvedTo == null ||
                            resultOvertime.approvedTo == ""
                        ? Colors.green.shade300
                        : Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                resultOvertime.disapprovedBy != null
                    ? "Disapproved"
                    : resultOvertime.approvedTo == null ||
                            resultOvertime.approvedTo == ""
                        ? "Approved"
                        : "Checking",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 7.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

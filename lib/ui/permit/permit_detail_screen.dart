import 'package:easy_hris/data/models/response/permit_model.dart';
import 'package:easy_hris/ui/permit/widgets/item_permit_detail.dart';
import 'package:easy_hris/ui/util/widgets/elevated_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/permits/permit_detail_provider.dart';
import '../../providers/permits/permit_provider.dart';
import '../util/utils.dart';
import '../util/widgets/app_bar_custom.dart';

class PermitDetailScreen extends StatelessWidget {
  const PermitDetailScreen({super.key, required this.resultPermit});

  final ResultPermitModel resultPermit;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PermitDetailProvider(resultPermit),
      child: Scaffold(
        appBar: AppbarCustom.appbar(context, title: "Permit Detail", leadingBack: true),
        body: Padding(
          padding: EdgeInsets.all(8.w),
          child: SingleChildScrollView(
            child: Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ItemPermitDetail(titleItem: "Permit Date", dataItem: formatDateReq(DateTime.parse(resultPermit.permitDate!))),
                    SizedBox(height: 8.h),
                    ItemPermitDetail(titleItem: "Permit Type", dataItem: resultPermit.permitTypeName ?? "-"),
                    SizedBox(height: 8.h),
                    ItemPermitDetail(titleItem: "Reason Name", dataItem: resultPermit.reasonName ?? "-"),
                    SizedBox(height: 8.h),
                    ItemPermitDetail(titleItem: "Start Time", dataItem: resultPermit.startTime ?? "-"),
                    SizedBox(height: 8.h),
                    ItemPermitDetail(titleItem: "End Time", dataItem: resultPermit.endTime ?? "-"),
                    SizedBox(height: 8.h),
                    ItemPermitDetail(titleItem: "Meal", dataItem: resultPermit.meal ?? "-"),
                    SizedBox(height: 8.h),
                    ItemPermitDetail(titleItem: "Note", dataItem: resultPermit.note ?? "-"),
                    SizedBox(height: 8.h),
                    ItemPermitDetail(titleItem: "Attachment", dataItem: resultPermit.attachment ?? "-"),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: resultPermit.status == '0' ? Colors.red.withAlpha(100) : Colors.green.withAlpha(100),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Column(
                          children: [
                            Text(
                              resultPermit.status == '0' ? "CHECKING" : "APPROVED",
                              style: TextStyle(
                                color: resultPermit.status == '0' ? Colors.red.shade700 : Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              resultPermit.status!.toUpperCase() == "0" ? resultPermit.approvedTo! : resultPermit.approvedBy!,
                              style: TextStyle(fontSize: 10.sp, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

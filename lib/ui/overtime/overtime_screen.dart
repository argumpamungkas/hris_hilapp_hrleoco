import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/providers/overtimes/overtime_provider.dart';
import 'package:easy_hris/providers/permits/permit_provider.dart';
import 'package:easy_hris/ui/permit/widgets/action_button_custom.dart';
import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
import 'package:easy_hris/ui/util/widgets/bottom_sheet_helpers.dart';
import 'package:easy_hris/ui/util/widgets/card_item_transaction.dart';
import 'package:easy_hris/ui/util/widgets/data_empty.dart';
import 'package:easy_hris/ui/util/widgets/item_detail_transaction.dart';
import 'package:easy_hris/ui/util/widgets/item_info_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../util/utils.dart';

class OvertimeScreen extends StatelessWidget {
  const OvertimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OvertimeProvider(),
      child: Scaffold(
        appBar: AppbarCustom.appbar(
          context,
          title: "Overtimes",
          leadingBack: true,
          action: [
            Consumer<OvertimeProvider>(
              builder: (context, prov, _) {
                if (prov.resultStatus == ResultStatus.hasData || prov.resultStatus == ResultStatus.noData) {
                  return IconButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, Routes.permitAddScreen).then((value) {
                      //   prov.fetchOvertime(prov.year);
                      // });
                    },
                    icon: Icon(Icons.add_box_rounded),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Consumer<OvertimeProvider>(
                builder: (context, prov, _) {
                  return Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ActionButtonCustom(
                          onTap: () {
                            prov.onChangeYear(false);
                          },
                          iconData: Icons.arrow_back_ios_new,
                        ),
                        Text(
                          prov.year.toString(),
                          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                        ),
                        ActionButtonCustom(
                          onTap: () {
                            prov.onChangeYear(true);
                          },
                          iconData: Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Remaining
              Consumer<OvertimeProvider>(
                builder: (context, prov, _) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(color: ConstantColor.bgIcon, borderRadius: BorderRadius.circular(8.w)),
                    child: Column(
                      spacing: 4.h,
                      children: [
                        ItemInfoTransaction(title: "Total Duration", value: "${prov.totalDuration} Hour"),
                        ItemInfoTransaction(title: "Total Amount", value: formatIDR(prov.totalAmount)),
                      ],
                    ),
                  );
                },
              ),

              SizedBox(height: 8.h),

              // List
              Expanded(
                child: Consumer<OvertimeProvider>(
                  builder: (context, prov, _) {
                    switch (prov.resultStatus) {
                      case ResultStatus.loading:
                        return Center(child: CupertinoActivityIndicator());
                      case ResultStatus.noData:
                        return Center(child: DataEmpty(dataName: "Overtimes"));
                      case ResultStatus.error:
                        return Center(child: Text(prov.message));
                      case ResultStatus.hasData:
                        return ListView.builder(
                          padding: EdgeInsets.all(10.w),
                          itemCount: prov.listOvertime.length,
                          itemBuilder: (context, index) {
                            final item = prov.listOvertime[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.pushNamed(context, Routes.permitDetailScreen, arguments: item);

                                  BottomSheetHelper.showModalDetail(
                                    context,
                                    title: "Overtimes Detail",
                                    columnList: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 8.h,
                                      children: [
                                        ItemDetailTransaction(title: "Request No", value: item.requestCode ?? ''),
                                        ItemDetailTransaction(title: "Request Date", value: formatDateReq(DateTime.parse(item.transDate!))),
                                        ItemDetailTransaction(title: "Requested Minute", value: item.duration ?? "-"),
                                        ItemDetailTransaction(title: "Breaktime", value: item.overtimeModelBreak ?? "-"),
                                        ItemDetailTransaction(title: "Start Time", value: item.start ?? "00:00"),
                                        ItemDetailTransaction(title: "End Time", value: item.end ?? "00:00"),
                                        ItemDetailTransaction(title: "Meal", value: item.meal ?? ""),
                                        ItemDetailTransaction(title: "Plan Amount", value: item.plan ?? ""),
                                        Container(
                                          padding: EdgeInsets.all(6.w),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(8.w),
                                          ),
                                          child: Text(
                                            "Attendance",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ItemDetailTransaction(title: "Overtime Minute", value: item.attendanceDuration ?? "-"),
                                        ItemDetailTransaction(title: "Start Time", value: item.attendanceIn ?? "-"),
                                        ItemDetailTransaction(title: "End Time", value: item.attendanceOut ?? "-"),
                                        ItemDetailTransaction(title: "Amount", value: formatIDR(int.parse(item.amount!) ?? 0)),
                                        ItemDetailTransaction(title: "Meal", value: item.overtimeMeal ?? "-"),
                                        Divider(),
                                        ItemDetailTransaction(title: "Plan Output", value: item.plan ?? "-"),
                                        ItemDetailTransaction(title: "Actual Output", value: item.actual ?? "-"),
                                        ItemDetailTransaction(title: "Work Description", value: item.remarks ?? "-"),
                                      ],
                                    ),
                                  );
                                },
                                child: CardItemTransaction(
                                  title: item.requestCode ?? '',
                                  subtitle: formatDateReq(DateTime.parse(item.transDate!)),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        item.status == '0' ? "CHECKING" : "APPROVED",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: item.status!.toUpperCase() == "0" ? Colors.red : Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        item.status!.toUpperCase() == "0" ? item.approvedTo! : item.approvedBy!,
                                        style: TextStyle(fontSize: 10.sp, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );

                      default:
                        return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

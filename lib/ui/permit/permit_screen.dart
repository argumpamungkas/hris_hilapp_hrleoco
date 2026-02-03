import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/providers/permits/permit_provider.dart';
import 'package:easy_hris/ui/permit/widgets/action_button_custom.dart';
import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
import 'package:easy_hris/ui/util/widgets/bottom_sheet_helpers.dart';
import 'package:easy_hris/ui/util/widgets/data_empty.dart';
import 'package:easy_hris/ui/util/widgets/item_detail_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../util/utils.dart';

class PermitScreen extends StatelessWidget {
  const PermitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PermitProvider(),
      child: Scaffold(
        appBar: AppbarCustom.appbar(
          context,
          title: "Permits",
          leadingBack: true,
          action: [
            Consumer<PermitProvider>(
              builder: (context, prov, _) {
                if (prov.resultStatus == ResultStatus.hasData || prov.resultStatus == ResultStatus.noData) {
                  return IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.permitAddScreen).then((value) {
                        prov.fetchPermit(prov.year);
                      });
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
              Consumer<PermitProvider>(
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(color: ConstantColor.bgIcon, borderRadius: BorderRadius.circular(8.w)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Remaining Leave",
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Consumer<PermitProvider>(
                      builder: (context, prov, _) {
                        if (prov.resultStatus == ResultStatus.loading) {
                          return CupertinoActivityIndicator();
                        }

                        if (prov.resultStatus == ResultStatus.error || prov.resultStatus == ResultStatus.noData) {
                          return Text(
                            // "11 Days",
                            "0 Days",
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
                          );
                        }

                        return Text(
                          "${prov.remaining} Days",
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.h),

              // List
              Expanded(
                child: Consumer<PermitProvider>(
                  builder: (context, prov, _) {
                    switch (prov.resultStatus) {
                      case ResultStatus.loading:
                        return Center(child: CupertinoActivityIndicator());
                      case ResultStatus.noData:
                        return Center(child: DataEmpty(dataName: "Permit"));
                      case ResultStatus.error:
                        return Center(child: Text(prov.message));
                      case ResultStatus.hasData:
                        return ListView.builder(
                          padding: EdgeInsets.all(10.w),
                          itemCount: prov.listPermit.length,
                          itemBuilder: (context, index) {
                            final item = prov.listPermit[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.pushNamed(context, Routes.permitDetailScreen, arguments: item);

                                  BottomSheetHelper.showModalDetail(
                                    context,
                                    title: "Permit Detail",
                                    columnList: Column(
                                      spacing: 8.h,
                                      children: [
                                        ItemDetailTransaction(title: "Permit Date", value: formatDateReq(DateTime.parse(item.permitDate!))),
                                        ItemDetailTransaction(title: "Permit Type", value: item.permitTypeName ?? "-"),
                                        ItemDetailTransaction(title: "Reason Name", value: item.reasonName ?? "-"),
                                        ItemDetailTransaction(title: "Start Time", value: item.startTime ?? "00:00"),
                                        ItemDetailTransaction(title: "End Time", value: item.endTime ?? "00:00"),
                                        ItemDetailTransaction(title: "Meal", value: item.meal ?? ""),
                                        ItemDetailTransaction(title: "Note", value: item.note ?? ""),
                                        ItemDetailTransaction(title: "Attachment", value: item.attachment ?? "-"),
                                      ],
                                    ),
                                  );
                                },
                                child: Card(
                                  surfaceTintColor: Colors.white,
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: Container(
                                      padding: EdgeInsets.all(4.w),
                                      decoration: BoxDecoration(color: ConstantColor.bgIcon, borderRadius: BorderRadius.circular(8.w)),
                                      child: Icon(Icons.file_present_outlined),
                                    ),
                                    title: Column(
                                      spacing: 3.h,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          item.permitTypeName ?? "",
                                          style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                        ),
                                        Text(
                                          formatDateReq(DateTime.parse(item.permitDate!)),
                                          style: TextStyle(fontSize: 10.sp, color: Colors.black, fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    // subtitle: Text("30 December 2026"),
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

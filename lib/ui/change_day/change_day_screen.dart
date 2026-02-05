import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/providers/change_days/change_day_provider.dart';
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
import '../util/widgets/shimmer_list_load_data.dart';

class ChangeDayScreen extends StatelessWidget {
  const ChangeDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangeDayProvider(),
      child: Scaffold(
        appBar: AppbarCustom.appbar(
          context,
          title: "Change Day",
          leadingBack: true,
          action: [
            Consumer<ChangeDayProvider>(
              builder: (context, prov, _) {
                if (prov.resultStatus == ResultStatus.hasData || prov.resultStatus == ResultStatus.noData) {
                  return IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.changeDayAddScreen).then((value) {
                        prov.fetchChangeDay(prov.year);
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
              Consumer<ChangeDayProvider>(
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

              // List
              Expanded(
                child: Consumer<ChangeDayProvider>(
                  builder: (context, prov, _) {
                    switch (prov.resultStatus) {
                      case ResultStatus.loading:
                        return ShimmerListLoadData();
                      case ResultStatus.noData:
                        return Center(child: DataEmpty(dataName: "Change Day"));
                      case ResultStatus.error:
                        return Center(child: Text(prov.message));
                      case ResultStatus.hasData:
                        return ListView.builder(
                          padding: EdgeInsets.all(10.w),
                          itemCount: prov.listChangeDay.length,
                          itemBuilder: (context, index) {
                            final item = prov.listChangeDay[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.pushNamed(context, Routes.permitDetailScreen, arguments: item);

                                  BottomSheetHelper.showModalDetail(
                                    context,
                                    title: "Change Day Detail",
                                    columnList: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 8.h,
                                      children: [
                                        ItemDetailTransaction(title: "Day From", value: formatDateReq(DateTime.parse(item.start!))),
                                        ItemDetailTransaction(title: "Replace To", value: formatDateReq(DateTime.parse(item.end!))),
                                        ItemDetailTransaction(title: "Note", value: item.remarks ?? "-"),
                                      ],
                                    ),
                                  );
                                },
                                child: CardItemTransaction(
                                  title: formatDateReq(DateTime.parse(item.start!)),
                                  subtitle: item.remarks ?? '',
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Text(
                                      //   item.status == '0' ? "CHECKING" : "APPROVED",
                                      //   style: TextStyle(
                                      //     fontSize: 12.sp,
                                      //     color: item.status!.toUpperCase() == "0" ? Colors.red : Colors.green,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      // Text(
                                      //   item.status!.toUpperCase() == "0" ? item.approvedTo! : item.approvedBy!,
                                      //   style: TextStyle(fontSize: 10.sp, color: Colors.black),
                                      // ),
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

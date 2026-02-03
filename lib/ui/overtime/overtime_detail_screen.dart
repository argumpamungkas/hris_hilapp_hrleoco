import 'package:easy_hris/ui/overtime/widgets/item_overtime_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../data/models/overtime.dart';
import '../../providers/overtimes/overtime_detail_provider.dart';
import '../../providers/overtimes/overtime_provider.dart';
import '../util/utils.dart';
import '../util/widgets/app_bar_custom.dart';
import '../util/widgets/elevated_button_custom.dart';
import '../util/widgets/foto_screen.dart';

class OvertimeDetailScreen extends StatelessWidget {
  const OvertimeDetailScreen({super.key, required this.resultOvertime});

  final ResultsOvertime resultOvertime;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OvertimeDetailProvider(resultOvertime),
      child: Scaffold(
        appBar: AppbarCustom.appbar(context, title: "Overtime Detail", leadingBack: true),
        body: Consumer2<OvertimeDetailProvider, OvertimeProvider>(
          builder: (context, provOvertimeDetail, provOvertime, _) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              children: [
                Text(
                  provOvertimeDetail.transDate,
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "Request Code", dataItem: resultOvertime.requestCode ?? "-"),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "Document No", dataItem: resultOvertime.idmNo ?? "-"),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "Start", dataItem: resultOvertime.start != null ? provOvertimeDetail.start : "-"),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "End", dataItem: resultOvertime.end != null ? provOvertimeDetail.end : "-"),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "Work Duration", dataItem: resultOvertime.duration ?? "-"),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "Break", dataItem: resultOvertime.resBreak ?? "-"),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "Meal", dataItem: resultOvertime.meal == "0" ? "No" : "Yes"),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "Plan Overtime", dataItem: resultOvertime.plan ?? "0"),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "Actual Overtime", dataItem: resultOvertime.actual ?? "0"),
                const SizedBox(height: 16),
                Text(
                  "Attendance",
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "Time In", dataItem: resultOvertime.timeIn != null ? provOvertimeDetail.timeIn : "-"),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "Time Out", dataItem: resultOvertime.timeOut != null ? provOvertimeDetail.timeOut : "-"),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "Plan Amount", dataItem: "Rp. ${idrFormat.format(resultOvertime.amountActual!)}"),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(titleItem: "Actual Amount", dataItem: "Rp. ${idrFormat.format(resultOvertime.amountActual!)}"),
                SizedBox(height: 8.h),
                ItemOvertimeDetail(
                  titleItem: "Remarks",
                  dataItem: resultOvertime.remarks != null || resultOvertime.remarks! != "-" ? resultOvertime.remarks! : "-",
                ),
                // resultOvertime.attachment != null
                //     ? Column(
                //         children: [
                //           SizedBox(height: 26.h),
                //           GestureDetector(
                //             onTap: () => Navigator.pushNamed(
                //               context,
                //               FotoScreen.routeName,
                //               arguments: "${provOvertime.linkServer}/${resultOvertime.attachmentLink!}",
                //             ),
                //             child: Hero(
                //               tag: "${provOvertime.linkServer}/${resultOvertime.attachmentLink!}",
                //               child: Image.network("${provOvertime.linkServer}/${resultOvertime.attachmentLink!}", height: 200.h),
                //             ),
                //           ),
                //         ],
                //       )
                //     : Container(),
                // SizedBox(height: 16.h),
                // ElevatedButtonCustom(
                //   onPressed: resultOvertime.approvedTo == null || resultOvertime.approvedTo == ""
                //       ? null
                //       : () {
                //           showConfirmDialog(
                //             context,
                //             titleConfirm: "Confirm",
                //             descriptionConfirm: "Are you sure for cancel request?",
                //             action: [
                //               TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                //               TextButton(
                //                 onPressed: () async {
                //                   if (!context.mounted) return;
                //                   Navigator.pop(context);
                //                   showLoadingDialog(context);
                //                   await provOvertimeDetail.cancelRequestOvertime(resultOvertime.id!).then((value) async {
                //                     // print("VALUE $value");
                //                     if (value) {
                //                       await provOvertime.fetchOvertime(provOvertime.initDate.year);
                //                       if (!context.mounted) return;
                //                       showInfoSnackbar(context, provOvertimeDetail.message);
                //                       Navigator.pop(context);
                //                       Navigator.pop(context);
                //                     } else {
                //                       if (!context.mounted) return;
                //                       Navigator.pop(context);
                //                       showFailedDialog(context, titleFailed: "Failed", descriptionFailed: provOvertimeDetail.message);
                //                     }
                //                   });
                //                 },
                //                 child: const Text("Yes"),
                //               ),
                //             ],
                //           );
                //         },
                //   title: "Cancel Request",
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

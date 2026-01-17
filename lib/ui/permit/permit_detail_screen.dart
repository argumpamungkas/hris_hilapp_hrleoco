import 'package:easy_hris/ui/permit/widgets/item_permit_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../data/models/permit.dart';
import '../../providers/permits/permit_detail_provider.dart';
import '../../providers/permits/permit_provider.dart';
import '../util/utils.dart';
import '../util/widgets/app_bar_custom.dart';
import '../util/widgets/elevated_button_custom.dart';
import '../util/widgets/foto_screen.dart';

class PermitDetailScreen extends StatelessWidget {
  const PermitDetailScreen({super.key, required this.resultPermit});

  final ResultPermit resultPermit;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PermitDetailProvider(resultPermit),
      child: Scaffold(
        appBar: appBarCustom(context, title: "Permit Detail", leadingBack: true),
        body: Consumer2<PermitDetailProvider, PermitProvider>(
          builder: (context, provPermitDetail, provPermit, _) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              children: [
                ItemPermitDetail(titleItem: "Request ID", dataItem: resultPermit.id),
                SizedBox(height: 8.h),
                ItemPermitDetail(titleItem: "Permit Date", dataItem: provPermitDetail.permitDate),
                SizedBox(height: 8.h),
                ItemPermitDetail(titleItem: "Permit Type", dataItem: resultPermit.permitTypeName ?? "-"),
                SizedBox(height: 8.h),
                ItemPermitDetail(titleItem: "Reason", dataItem: resultPermit.reasonName ?? "-"),
                SizedBox(height: 8.h),
                ItemPermitDetail(titleItem: "Permit Available", dataItem: resultPermit.leave ?? "-"),
                SizedBox(height: 8.h),
                ItemPermitDetail(titleItem: "Remarks", dataItem: resultPermit.note ?? "-"),
                resultPermit.attachment != null
                    ? Column(
                        children: [
                          SizedBox(height: 26.h),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              FotoScreen.routeName,
                              arguments: "${provPermit.linkServer}/${resultPermit.fileAttachment!}",
                            ),
                            child: Hero(
                              tag: "${provPermit.linkServer}/${resultPermit.fileAttachment!}",
                              child: Image.network("${provPermit.linkServer}/${resultPermit.fileAttachment!}", height: 200.h),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(height: 16.h),
                ElevatedButtonCustom(
                  onPressed: resultPermit.approvedTo == null || resultPermit.approvedTo == ""
                      ? null
                      : () {
                          showConfirmDialog(
                            context,
                            titleConfirm: "Confirm",
                            descriptionConfirm: "Are you sure for cancel request?",
                            action: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                              TextButton(
                                onPressed: () async {
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                  showLoadingDialog(context);
                                  await provPermitDetail.cancelRequestPermit(resultPermit.id).then((value) async {
                                    // print("VALUE $value");
                                    if (value) {
                                      await provPermit.fetchPermit(provPermit.initDate.year);
                                      if (!context.mounted) return;
                                      showInfoSnackbar(context, provPermitDetail.message);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    } else {
                                      if (!context.mounted) return;
                                      Navigator.pop(context);
                                      showFailedDialog(context, titleFailed: "Failed", descriptionFailed: provPermitDetail.message);
                                    }
                                  });
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                  title: "Cancel Request",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

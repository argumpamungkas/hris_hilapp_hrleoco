import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
import 'package:easy_hris/ui/util/widgets/elevated_button_custom.dart';
import 'package:easy_hris/ui/util/widgets/text_field_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../constant/routes.dart';
import '../../providers/permits/permit_add_provider.dart';
import '../../providers/preferences_provider.dart';
import '../util/utils.dart';
import '../util/widgets/bottom_sheet_helpers.dart';
import '../util/widgets/dialog_helpers.dart';
import '../util/widgets/elevated_button_custom_icon.dart';

class PermitAddScreen extends StatelessWidget {
  const PermitAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PermitAddProvider(),
      child: Scaffold(
        // backgroundColor: prov.isDarkTheme ? Theme.of(context).scaffoldBackgroundColor : ConstantColor.bgColorWhite,
        appBar: AppbarCustom.appbar(context, title: "Add Permit", leadingBack: true),
        body: Consumer<PermitAddProvider>(
          builder: (context, prov, _) {
            switch (prov.resultStatus) {
              case ResultStatus.loading:
                return Center(child: CupertinoActivityIndicator());
              case ResultStatus.noData:
                return Center(child: Text(prov.message));
              case ResultStatus.error:
                return Center(child: Text(prov.message));
              case ResultStatus.hasData:
                return Padding(
                  padding: EdgeInsets.all(8.w),
                  child: SingleChildScrollView(
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Form(
                          key: prov.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFieldCustom(
                                controller: prov.permitDateController,
                                label: "Permit Date",
                                hint: "DD MMMM YYYY",
                                isRequired: true,
                                enabled: true,
                                readOnly: true,
                                iconSuffix: IconButton(
                                  icon: const Icon(Iconsax.calendar_add_outline),
                                  onPressed: () async {
                                    final now = DateTime.now().toLocal();

                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: now,
                                      firstDate: DateTime(1900),
                                      lastDate: now.add(Duration(days: 365)),
                                    );

                                    if (pickedDate != null) {
                                      prov.onChangePicker(pickedDate);
                                    }
                                  },
                                ),
                              ),

                              SizedBox(height: 16.h),

                              TextFieldCustom(
                                controller: prov.permitTypeController,
                                label: "Permit Type",
                                hint: "Choose Permit Type",
                                isRequired: true,
                                enabled: true,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                onTap: () {
                                  DialogHelper.showSelectedDialog(
                                    context,
                                    title: "Select Permit Type",
                                    listData: prov.listPermitType,
                                    itemBuilder: (context, item, index) {
                                      return Card(
                                        child: ListTile(
                                          onTap: () async {
                                            prov.onChangePermitType(item);

                                            // fetch reason
                                            DialogHelper.showLoadingDialog(context);
                                            final result = await prov.fetchPermitReason(item);

                                            if (!context.mounted) return;
                                            // jika gagal fetch maka munculkan alert
                                            if (!result) {
                                              DialogHelper.showInfoDialog(
                                                context,
                                                title: prov.title,
                                                message: prov.message,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                              );
                                            } else {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            }
                                          },
                                          title: Text(item.name!, textAlign: TextAlign.center),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

                              SizedBox(height: 16.h),

                              TextFieldCustom(
                                controller: prov.reasonNameController,
                                label: "Reason Name",
                                hint: "Choose Reason",
                                isRequired: true,
                                enabled: true,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                onTap: () {
                                  DialogHelper.showSelectedDialog(
                                    context,
                                    title: "Select Reason Name",
                                    listData: prov.listReason,
                                    itemBuilder: (context, item, index) {
                                      return Card(
                                        child: ListTile(
                                          onTap: () async {
                                            prov.onChangeReason(item);
                                            Navigator.pop(context);
                                          },
                                          title: Text(item.name!, textAlign: TextAlign.center),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

                              prov.permitTypeModel != null && prov.permitTypeModel?.meal == '1'
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(height: 16.h),
                                        TextFieldCustom(controller: prov.startTimeController, label: "Start Time", hint: "Start Time"),
                                        SizedBox(height: 16.h),
                                        TextFieldCustom(controller: prov.endTimeController, label: "End Time", hint: "End Time"),
                                      ],
                                    )
                                  : SizedBox.shrink(),

                              SizedBox(height: 16.h),

                              TextFieldCustom(
                                controller: prov.noteController,
                                label: "Note",
                                hint: "Note",
                                enabled: true,
                                isRequired: true,
                                keyboardType: TextInputType.text,
                              ),

                              SizedBox(height: 16.h),

                              TextFieldCustom(
                                controller: prov.attachmentController,
                                label: "Attachment",
                                hint: "Choose File Attachment",
                                readOnly: true,
                                isRequired: prov.permitTypeModel != null && prov.permitTypeModel?.attachment?.toUpperCase() == "YES" ? true : false,
                                maxLine: 1,
                                iconPrefix: prov.attachment != null
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, Routes.viewImageScreen, arguments: prov.attachment);
                                        },
                                        child: Icon(Icons.visibility, size: 16.sp),
                                      )
                                    : null,
                                // onTap: () {
                                //   BottomSheetHelper.showUploadOptions(context, (file, base64) async {
                                //     await Future.delayed(Duration(milliseconds: 100));
                                //     if (!context.mounted) return;
                                //     showLoadingDialog(context);
                                //
                                //     // prov.onChangeFileTaxNPWP(file, base64);
                                //
                                //     Navigator.pop(context);
                                //   });
                                // },
                                iconSuffix: IconButton(
                                  onPressed: () {
                                    BottomSheetHelper.showUploadOptions(context, (file, base64) async {
                                      await Future.delayed(Duration(milliseconds: 100));
                                      if (!context.mounted) return;
                                      showLoadingDialog(context);

                                      prov.onChangeAttachment(file, base64);

                                      Navigator.pop(context);
                                    });
                                  },
                                  icon: Icon(Iconsax.camera_outline),
                                ),
                              ),

                              // Visibility(
                              //   visible: prov.permitTypeModel != null && prov.permitTypeModel?.attachment?.toUpperCase() == "YES" ? true : false,
                              //   child: Text(
                              //     "*Attachment is Required",
                              //     style: TextStyle(color: Colors.red, fontSize: 10.sp),
                              //   ),
                              // ),
                              SizedBox(height: 24.h),

                              ElevatedButtonCustomIcon(
                                onPressed: () async {
                                  if (prov.formKey.currentState!.validate()) {
                                    showLoadingDialog(context);

                                    final result = await prov.addPermit();

                                    if (!context.mounted) return;
                                    Navigator.pop(context);
                                    if (result) {
                                      DialogHelper.showInfoDialog(
                                        context,
                                        icon: Icon(Icons.check, size: 32, color: Colors.green),
                                        title: prov.title,
                                        message: prov.message,
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      );
                                    } else {
                                      DialogHelper.showInfoDialog(
                                        context,
                                        icon: Icon(Icons.close_rounded, size: 32, color: Colors.red.shade700),
                                        title: prov.title,
                                        message: prov.message,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    }
                                  }
                                },
                                title: "Save Data",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              default:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

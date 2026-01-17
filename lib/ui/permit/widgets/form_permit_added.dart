import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/models/permit_type.dart';
import '../../../providers/permits/permit_added_provider.dart';
import '../../../providers/permits/permit_provider.dart';
import '../../../providers/preferences_provider.dart';
import '../../util/utils.dart';
import '../../util/widgets/elevated_button_custom.dart';
import '../../util/widgets/photo_bottom_sheet.dart';
import '../../util/widgets/preview_photo.dart';
import '../../util/widgets/title_form.dart';

class FormPermitAdded extends StatelessWidget {
  const FormPermitAdded({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<PermitAddedProvider, PermitProvider, PreferencesProvider>(
      builder: (context, provPermitAdded, provPermit, provPref, _) {
        return Form(
          key: provPermitAdded.formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleForm(textTitle: "Date From"),
                  SizedBox(height: 4.h),
                  TextFormField(
                    controller: provPermitAdded.dateFromC,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 12.sp),
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Date From",
                      suffixIcon: IconButton(
                        onPressed: () {
                          provPermitAdded.openCalendarFrom(context);
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please input Date From";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleForm(textTitle: "Date To"),
                  SizedBox(height: 4.h),
                  TextFormField(
                    controller: provPermitAdded.dateToC,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 12.sp),
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Date To",
                      suffixIcon: IconButton(
                        onPressed: () {
                          provPermitAdded.openCalendarTo(context);
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please input Date To";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleForm(textTitle: "Permit Type"),
                  SizedBox(height: 4.h),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      dropdownColor: provPref.isDarkTheme ? Colors.grey.shade900 : Colors.white,
                      value: provPermitAdded.permitType,
                      validator: (value) {
                        if (value == null) {
                          return "Please input Permit Type";
                        }
                        return null;
                      },
                      items: provPermitAdded.lisPermitType.map((PermitType permit) {
                        return DropdownMenuItem(
                          value: permit,
                          child: SizedBox(
                            width: 0.6.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(permit.name!, style: TextStyle(fontSize: 10.sp)),
                                SizedBox(width: 1.h),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: provPermitAdded.dateFromC.text.isEmpty || provPermitAdded.dateToC.text.isEmpty
                          ? null
                          : (value) async {
                              provPermitAdded.onClearReason();
                              showLoadingDialog(context);
                              // await Future.delayed(const Duration(seconds: 1));
                              await provPermitAdded.fetchPermitReason(value as PermitType).then((value) {
                                if (value) {
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                } else {
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                  showFailedDialog(context, titleFailed: "Failed", descriptionFailed: provPermitAdded.message);
                                }
                              });
                            },
                      alignment: Alignment.centerLeft,
                      hint: Text(
                        "Permit Type",
                        style: TextStyle(color: Colors.grey, fontSize: 10.sp, fontWeight: FontWeight.bold),
                      ),
                      iconEnabledColor: Colors.grey,
                      iconDisabledColor: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleForm(textTitle: "Reason"),
                  SizedBox(height: 4.h),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      dropdownColor: provPref.isDarkTheme ? Colors.grey.shade900 : Colors.white,
                      // value: provPermitAdded.permitReason,
                      value: provPermitAdded.permitReason,
                      validator: (value) {
                        if (value == null) {
                          return "Please input Reason";
                        }
                        return null;
                      },
                      items: provPermitAdded.lisPermitReason.map((permit) {
                        return DropdownMenuItem(
                          value: permit.id.toString(),
                          child: SizedBox(
                            width: 0.6.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(permit!.name!, maxLines: 1, style: TextStyle(fontSize: 10.sp)),
                                SizedBox(width: 1.h),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        showLoadingDialog(context);
                        // await Future.delayed(const Duration(seconds: 1));
                        await provPermitAdded.fetchPermitAvailable(value!).then((value) {
                          if (!context.mounted) return;
                          Navigator.pop(context);
                        });
                      },
                      alignment: Alignment.centerLeft,
                      hint: Text(
                        "Reason",
                        style: TextStyle(color: Colors.grey, fontSize: 10.sp, fontWeight: FontWeight.bold),
                      ),
                      iconEnabledColor: Colors.grey,
                      iconDisabledColor: Colors.grey,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: provPermitAdded.permitType != null && provPermitAdded.permitType?.name == "CUTI" ? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    const TitleForm(textTitle: "Permit Available"),
                    SizedBox(height: 4.h),
                    TextFormField(
                      controller: provPermitAdded.permitAvailableC,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 12.sp),
                      readOnly: true,
                      decoration: const InputDecoration(hintText: "Permit Available"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please input Permit Available";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleForm(textTitle: "Remarks"),
                  SizedBox(height: 4.h),
                  TextFormField(
                    controller: provPermitAdded.remarksC,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(fontSize: 12.sp),
                    decoration: const InputDecoration(hintText: "Remarks"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please input Remarks";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              provPermitAdded.selectImage == null
                  ? Column(
                      children: [
                        Text("File jpg/png", style: TextStyle(fontSize: 9.sp)),
                        Text(
                          provPermitAdded.info,
                          style: TextStyle(color: Colors.red, fontSize: 8.sp),
                        ),
                      ],
                    )
                  : PreviewPhoto(selectImage: provPermitAdded.selectImage),
              SizedBox(height: 4.h),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return PhotoBottomSheet(
                            openGallery: () async {
                              Navigator.pop(context);
                              await provPermitAdded.openGallery(context);
                            },
                            openCamera: () async {
                              Navigator.pop(context);
                              await provPermitAdded.openCamera(context);
                            },
                          );
                        },
                      );
                    },
                    child: const Text("Attachment"),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              ElevatedButtonCustom(
                onPressed: () async {
                  if (provPermitAdded.formKey.currentState!.validate()) {
                    showLoadingDialog(context);
                    if (provPermitAdded.totalAvailable == 0) {
                      Navigator.pop(context);
                      return showFailedDialog(context, titleFailed: "Failed", descriptionFailed: "Permit available has been exhausted");
                    } else {
                      var respPermitType = provPermitAdded.checkPermitType();
                      if (respPermitType) {
                        if (provPermitAdded.selectImage != null) {
                          await provPermitAdded.addPermit().then((value) async {
                            if (value == false) {
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              showFailedDialog(context, titleFailed: "Failed", descriptionFailed: provPermitAdded.message);
                              return;
                            }

                            if (value.theme == "success") {
                              if (!context.mounted) return;
                              await provPermit.fetchPermit(provPermit.initDate.year);
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              showFailedDialog(context, titleFailed: value.title, descriptionFailed: value.message);
                            }
                          });
                        } else {
                          await provPermitAdded.addPermit().then((value) async {
                            if (value == false) {
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              showFailedDialog(context, titleFailed: "Failed", descriptionFailed: provPermitAdded.message);
                              return;
                            }

                            if (value.theme == "success") {
                              if (!context.mounted) return;
                              await provPermit.fetchPermit(provPermit.initDate.year);
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              showFailedDialog(context, titleFailed: value.title, descriptionFailed: value.message);
                            }
                          });
                        }
                      } else {
                        Navigator.pop(context);
                        return showFailedDialog(
                          context,
                          titleFailed: "Failed",
                          descriptionFailed: "Attachment is Empty. Attachment is Required for Permit Type ${provPermitAdded.permitType!.name}.",
                        );
                      }
                    }
                  }
                },
                title: 'Send Request',
              ),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../providers/overtimes/overtime_added_provider.dart';
import '../../../providers/overtimes/overtime_provider.dart';
import '../../../providers/preferences_provider.dart';
import '../../util/utils.dart';
import '../../util/widgets/elevated_button_custom.dart';
import '../../util/widgets/photo_bottom_sheet.dart';
import '../../util/widgets/preview_photo.dart';
import '../../util/widgets/title_form.dart';

class FormOvertimeAdded extends StatelessWidget {
  const FormOvertimeAdded({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<OvertimeAddedProvider, OvertimeProvider, PreferencesProvider>(
      builder: (context, provOvertimeAdded, provOvertime, prefProv, _) {
        switch (provOvertimeAdded.resultStatus) {
          case ResultStatus.loading:
            return const CircularProgressIndicator();
          case ResultStatus.error:
            return const Text("Error");
          case ResultStatus.hasData || ResultStatus.init:
            return Form(
              key: provOvertimeAdded.formKey,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleForm(textTitle: "Overtime Date"),
                      SizedBox(height: 4.h),
                      TextFormField(
                        controller: provOvertimeAdded.requestDateController,
                        textInputAction: TextInputAction.next,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Overtime Date",
                          suffixIcon: IconButton(
                            onPressed: () {
                              provOvertimeAdded.openCalendar(context);
                            },
                            icon: const Icon(Icons.calendar_month_outlined),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please input Request Date";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TitleForm(textTitle: "Start"),
                                SizedBox(height: 4.h),
                                TextFormField(
                                  controller: provOvertimeAdded.startController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  decoration: const InputDecoration(hintText: "Start"),
                                  onTap: provOvertimeAdded.readOnlyStart
                                      ? null
                                      : () {
                                          provOvertimeAdded.openTimeStart(context);
                                        },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please input Start";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.h),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TitleForm(textTitle: "End"),
                                SizedBox(height: 4.h),
                                TextFormField(
                                  controller: provOvertimeAdded.endController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  decoration: const InputDecoration(hintText: "End"),
                                  onTap: provOvertimeAdded.readOnlyEnd
                                      ? null
                                      : () {
                                          provOvertimeAdded.openTimeEnd(context);
                                        },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please input End";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      const TitleForm(textTitle: "Break"),
                      SizedBox(height: 4.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: provOvertimeAdded.breakController,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        decoration: const InputDecoration(hintText: "Break"),
                                        onChanged: (value) {
                                          provOvertimeAdded.onChangedBreak(value);
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please input Break";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 8.h),
                                    Expanded(
                                      child: Text(
                                        "Hour",
                                        style: TextStyle(fontSize: 11.sp, color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.h),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                  value: provOvertimeAdded.isMeal,
                                  onChanged: (value) {
                                    provOvertimeAdded.onChangeMeal(value!);
                                  },
                                ),
                                const Text("Meal", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Plan ",
                                      style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "(Hour)",
                                        style: TextStyle(fontSize: 10.sp, color: Colors.red, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                TextFormField(
                                  controller: provOvertimeAdded.planController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  readOnly: provOvertimeAdded.readOnlyPlan,
                                  decoration: const InputDecoration(hintText: "Plan"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.h),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Actual ",
                                      style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "(Hour)",
                                        style: TextStyle(fontSize: 10.sp, color: Colors.red, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                TextFormField(
                                  controller: provOvertimeAdded.actualController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  readOnly: true,
                                  decoration: const InputDecoration(hintText: "Actual"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleForm(textTitle: "Remarks"),
                          SizedBox(height: 4.h),
                          TextFormField(
                            controller: provOvertimeAdded.remarksController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.done,
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
                      provOvertimeAdded.selectImage == null
                          ? Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "File jpg/png",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 9.sp),
                                  ),
                                  Text(
                                    provOvertimeAdded.infoFile,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.red, fontSize: 8.sp),
                                  ),
                                ],
                              ),
                            )
                          : Center(child: PreviewPhoto(selectImage: provOvertimeAdded.selectImage)),
                      SizedBox(height: 4.h),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return PhotoBottomSheet(openGallery: provOvertimeAdded.openGallery, openCamera: provOvertimeAdded.openCamera);
                              },
                            );
                          },
                          child: const Text("Attachment"),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      ElevatedButtonCustom(
                        onPressed: () async {
                          if (provOvertimeAdded.formKey.currentState!.validate()) {
                            showLoadingDialog(context);
                            if (provOvertimeAdded.selectImage != null) {
                              if (!context.mounted) return;
                              await provOvertimeAdded.addOvertime(context).then((value) async {
                                if (value.theme == "success") {
                                  if (!context.mounted) return;
                                  // await provOvertime.fetchOvertime(provOvertime.initDate.year).then((_) {
                                  //   if (!context.mounted) return;
                                  //   Navigator.pop(context);
                                  //   Navigator.pop(context);
                                  // });
                                } else {
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                  showFailedDialog(context, titleFailed: value.title, descriptionFailed: value.message);
                                }
                              });
                            } else {
                              if (!context.mounted) return;
                              await provOvertimeAdded.addOvertime(context).then((value) async {
                                // print("VALUE $value");
                                if (value.theme == "success") {
                                  if (!context.mounted) return;
                                  // await provOvertime.fetchOvertime(provOvertime.initDate.year).then((_) {
                                  //   if (!context.mounted) return;
                                  //   Navigator.pop(context);
                                  //   Navigator.pop(context);
                                  // });
                                } else {
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                  showFailedDialog(context, titleFailed: value.title, descriptionFailed: value.message);
                                }
                              });
                            }
                          }
                        },
                        title: "Send Request",
                      ),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     if (provOvertimeAdded.formKey.currentState!
                      //         .validate()) {
                      //       showLoadingDialog(context);
                      //       if (provOvertimeAdded.selectImage != null) {
                      //         if (!context.mounted) return;
                      //         await provOvertimeAdded.addOvertime(context).then(
                      //           (value) async {
                      //             if (value.theme == "success") {
                      //               if (!context.mounted) return;
                      //               await provOvertime
                      //                   .fetchOvertime(
                      //                       provOvertime.initDate.year)
                      //                   .then(
                      //                 (_) {
                      //                   if (!context.mounted) return;
                      //                   Navigator.pop(context);
                      //                   Navigator.pop(context);
                      //                 },
                      //               );
                      //             } else {
                      //               if (!context.mounted) return;
                      //               Navigator.pop(context);
                      //               showFailedDialog(
                      //                 context,
                      //                 titleFailed: value.title,
                      //                 descriptionFailed: value.message,
                      //               );
                      //             }
                      //           },
                      //         );
                      //       } else {
                      //         if (!context.mounted) return;
                      //         await provOvertimeAdded.addOvertime(context).then(
                      //           (value) async {
                      //             print("VALUE $value");
                      //             if (value.theme == "success") {
                      //               if (!context.mounted) return;
                      //               await provOvertime
                      //                   .fetchOvertime(
                      //                       provOvertime.initDate.year)
                      //                   .then(
                      //                 (_) {
                      //                   if (!context.mounted) return;
                      //                   Navigator.pop(context);
                      //                   Navigator.pop(context);
                      //                 },
                      //               );
                      //             } else {
                      //               if (!context.mounted) return;
                      //               Navigator.pop(context);
                      //               showFailedDialog(
                      //                 context,
                      //                 titleFailed: value.title,
                      //                 descriptionFailed: value.message,
                      //               );
                      //             }
                      //           },
                      //         );
                      //       }
                      //     }
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: colorBlueDark,
                      //     foregroundColor: Colors.white,
                      //     textStyle: const TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 18,
                      //     ),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //     minimumSize: const Size.fromHeight(46),
                      //   ),
                      //   child: const Text("Send Request"),
                      // ),
                      SizedBox(height: 4.h),
                    ],
                  ),
                ],
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}

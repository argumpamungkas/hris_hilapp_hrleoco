import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import '../../../data/models/notifications/notification_detail_response_overtime.dart';
import '../../../data/models/notifications/notification_response.dart';
import '../../../providers/notifications/notification_detail_provider.dart';
import '../../../providers/notifications/notification_provider.dart';
import '../../../providers/overtimes/overtime_provider.dart';
import '../../util/utils.dart';
import '../../util/widgets/foto_screen.dart';
import 'item_data_notification.dart';

class OvertimeNotificationWidget extends StatelessWidget {
  const OvertimeNotificationWidget({
    super.key,
    required this.dataItem,
    required this.prov,
    required this.module,
    required this.dataNotif,
  });

  final List<ResultNotificationDetailOvertime> dataItem;
  final NotificationDetailProvider prov;
  final String module;
  final ResultNotif dataNotif;

  @override
  Widget build(BuildContext context) {
    return Consumer2<NotificationProvider, OvertimeProvider>(
        builder: (context, notifC, overtimeC, _) {
      late String? start, end, transDate;
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dataItem.length,
              itemBuilder: (context, index) {
                ResultNotificationDetailOvertime item = dataItem[index];
                if (item.start != null) {
                  var dateFormatDefautlt =
                      DateFormat("HH:mm:ss").parse(item.start!);
                  start = formatTimeAttendance(dateFormatDefautlt);
                }

                if (item.end != null) {
                  var dateFormatDefautlt =
                      DateFormat("HH:mm:ss").parse(item.end!);
                  end = formatTimeAttendance(dateFormatDefautlt);
                }

                if (item.transDate != null) {
                  var dateFormatDefautlt =
                      DateFormat("yyyy-MM-dd").parse(item.transDate!);
                  transDate = formatCreated(dateFormatDefautlt);
                }

                return Container(
                  padding: EdgeInsets.all(8.w.h),
                  margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      prov.selectAll == true
                          ? ZoomIn(
                              animate: true,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12.h.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                ],
                              ),
                            )
                          : Container(),
                      Column(
                        children: [
                          ItemDataNotification(
                            title: "Employee ID",
                            value: item.employeeId!,
                          ),
                          ItemDataNotification(
                            title: "Employee Name",
                            value: item.employeeName!,
                          ),
                          ItemDataNotification(
                            title: "Request Code",
                            value: item.requestCode!,
                          ),
                          ItemDataNotification(
                            title: "Document No",
                            value: item.idmNo ?? "-",
                          ),
                          ItemDataNotification(
                            title: "Overtime Date",
                            value: item.transDate != null ? transDate! : '-',
                          ),
                          ItemDataNotification(
                            title: "Start",
                            value: item.start != null ? start! : "-",
                          ),
                          ItemDataNotification(
                            title: "End",
                            value: item.end != null ? end! : "-",
                          ),
                          ItemDataNotification(
                            title: "Work Duration",
                            value: item.duration ?? "-",
                          ),
                          ItemDataNotification(
                            title: "Break",
                            value: item.resBreak ?? "-",
                          ),
                          ItemDataNotification(
                            title: "Meal",
                            value: item.meal == "0" ? "No" : "Yes",
                          ),
                          ItemDataNotification(
                            title: "Plan Overtime",
                            value: item.plan ?? "-",
                          ),
                          ItemDataNotification(
                            title: "Actual Overtime",
                            value: item.actual ?? "-",
                          ),
                          item.fileAttachment == null
                              ? Container()
                              : Column(
                                  children: [
                                    SizedBox(height: 16.h),
                                    InkWell(
                                      onTap: () => Navigator.pushNamed(
                                        context,
                                        FotoScreen.routeName,
                                        arguments:
                                            "${notifC.linkServer}${item.fileAttachment}",
                                      ),
                                      child: Image.network(
                                        "${notifC.linkServer}${item.fileAttachment}",
                                        height: 150,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      prov.selectAll == false
                          ? ZoomIn(
                              animate: true,
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          showConfirmDialog(
                                            context,
                                            titleConfirm: "Approve",
                                            descriptionConfirm:
                                                "Are you sure for approve ?",
                                            action: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  showLoadingDialog(context);
                                                  await prov
                                                      .approved(dataNotif,
                                                          item.id, module)
                                                      .then((value) {
                                                    Navigator.pop(context);
                                                    if (value.theme ==
                                                        "success") {
                                                      showLoadingDialog(
                                                          context);
                                                      notifC
                                                          .fetchNotification();
                                                      overtimeC.fetchOvertime(
                                                          overtimeC
                                                              .initDate.year);
                                                      Navigator.pop(context);
                                                      showInfoSnackbar(context,
                                                          value.message);
                                                    } else {
                                                      showFailSnackbar(context,
                                                          value.message);
                                                    }
                                                  });
                                                },
                                                child: const Text("Yes"),
                                              ),
                                            ],
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text("Approve"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          showConfirmDialog(
                                            context,
                                            titleConfirm: "Disapprove",
                                            descriptionConfirm:
                                                "Are you sure for disapprove ?",
                                            action: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  showLoadingDialog(context);
                                                  await prov
                                                      .disapproved(dataNotif,
                                                          item.id, module)
                                                      .then((value) {
                                                    Navigator.pop(context);
                                                    if (value.theme ==
                                                        "success") {
                                                      showLoadingDialog(
                                                          context);
                                                      notifC
                                                          .fetchNotification();
                                                      overtimeC.fetchOvertime(
                                                          overtimeC
                                                              .initDate.year);
                                                      Navigator.pop(context);
                                                      showInfoSnackbar(context,
                                                          value.message);
                                                    } else {
                                                      showFailSnackbar(context,
                                                          value.message);
                                                    }
                                                  });
                                                },
                                                child: const Text("Yes"),
                                              ),
                                            ],
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text("Disapprove"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
            ),
          ),
          prov.selectAll == true
              ? FadeInUp(
                  animate: true,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              showConfirmDialog(
                                context,
                                titleConfirm: "Approve All",
                                descriptionConfirm:
                                    "Are you sure for approve all ?",
                                action: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      showLoadingDialog(context);
                                      await prov
                                          .approvedAll(
                                        dataNotif: dataNotif,
                                        module: module,
                                      )
                                          .then((value) {
                                        Navigator.pop(context);
                                        if (value.theme == "success") {
                                          showLoadingDialog(context);
                                          notifC.fetchNotification();
                                          overtimeC.fetchOvertime(
                                              overtimeC.initDate.year);
                                          Navigator.pop(context);
                                          showInfoSnackbar(
                                              context, value.message);
                                        } else {
                                          showFailSnackbar(
                                              context, value.message);
                                        }
                                      });
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                              );
                            },
                            child: const Text("Approve All"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              showConfirmDialog(
                                context,
                                titleConfirm: "Disapprove All",
                                descriptionConfirm:
                                    "Are you sure for disapprove all ?",
                                action: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      showLoadingDialog(context);
                                      await prov
                                          .disapprovedAll(
                                        dataNotif: dataNotif,
                                        module: module,
                                      )
                                          .then((value) {
                                        Navigator.pop(context);
                                        if (value.theme == "success") {
                                          showLoadingDialog(context);
                                          notifC.fetchNotification();
                                          overtimeC.fetchOvertime(
                                              overtimeC.initDate.year);
                                          Navigator.pop(context);
                                          showInfoSnackbar(
                                              context, value.message);
                                        } else {
                                          showFailSnackbar(
                                              context, value.message);
                                        }
                                      });
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                              );
                            },
                            child: const Text("Disapprove All"),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      );
    });
  }
}

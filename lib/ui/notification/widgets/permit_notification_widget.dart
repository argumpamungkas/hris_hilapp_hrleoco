import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/models/notifications/notification_detail_response_permit.dart';
import '../../../data/models/notifications/notification_response.dart';
import '../../../providers/notifications/notification_detail_provider.dart';
import '../../../providers/notifications/notification_provider.dart';
import '../../../providers/permits/permit_provider.dart';
import '../../util/utils.dart';
import '../../util/widgets/foto_screen.dart';
import 'item_data_notification.dart';

class PermitNotificationWidget extends StatefulWidget {
  const PermitNotificationWidget({super.key, required this.dataItem, required this.prov, required this.module, required this.dataNotif});

  final List<ResultNotificationDetailPermit> dataItem;
  final NotificationDetailProvider prov;
  final String module;
  final ResultNotif dataNotif;

  @override
  State<PermitNotificationWidget> createState() => _PermitNotificationWidgetState();
}

class _PermitNotificationWidgetState extends State<PermitNotificationWidget> {
  late String _permitDate;

  @override
  Widget build(BuildContext context) {
    return Consumer2<NotificationProvider, PermitProvider>(
      builder: (context, notifC, permitC, _) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.dataItem.length,
                itemBuilder: (context, index) {
                  ResultNotificationDetailPermit item = widget.dataItem[index];
                  if (item.permitDate != null) {
                    var dateFormatDefautlt = DateFormat("yyyy-MM-dd").parse(item.permitDate!);
                    _permitDate = formatCreated(dateFormatDefautlt);
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
                        widget.prov.selectAll == true
                            ? ZoomIn(
                                animate: true,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                        child: Icon(Icons.check, color: Colors.white, size: 12.h.w),
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                  ],
                                ),
                              )
                            : Container(),
                        Column(
                          children: [
                            ItemDataNotification(title: "Employee ID", value: item.employeeId!),
                            ItemDataNotification(title: "Employee Name", value: item.employeeName!),
                            ItemDataNotification(title: "Request ID", value: item.id),
                            ItemDataNotification(title: "Permit Date", value: _permitDate),
                            ItemDataNotification(title: "Permit Type", value: item.permitTypeName ?? "-"),
                            ItemDataNotification(title: "Reason", value: item.reasonName ?? "-"),
                            ItemDataNotification(title: "Permit Available", value: item.leave ?? "-"),
                            ItemDataNotification(title: "Remarks", value: item.note ?? "-"),
                            item.fileAttachment == null
                                ? Container()
                                : Column(
                                    children: [
                                      SizedBox(height: 16.h),
                                      InkWell(
                                        onTap: () => Navigator.pushNamed(
                                          context,
                                          FotoScreen.routeName,
                                          arguments: "${notifC.linkServer}/${item.fileAttachment}",
                                        ),
                                        child: Image.network("${notifC.linkServer}/${item.fileAttachment}", height: 150),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        widget.prov.selectAll == false
                            ? ZoomIn(
                                animate: true,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            showConfirmDialog(
                                              context,
                                              titleConfirm: "Approve",
                                              descriptionConfirm: "Are you sure for approve ?",
                                              action: [
                                                TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    showLoadingDialog(context);
                                                    await widget.prov.approved(widget.dataNotif, item.id, widget.module).then((value) async {
                                                      Navigator.pop(context);
                                                      if (value.theme == "success") {
                                                        showLoadingDialog(context);
                                                        notifC.fetchNotification();
                                                        // permitC.fetchPermit(permitC.initDate.year);
                                                        Navigator.pop(context);
                                                        showInfoSnackbar(context, value.message);
                                                      } else {
                                                        showFailSnackbar(context, value.message);
                                                      }
                                                    });
                                                  },
                                                  child: const Text("Yes"),
                                                ),
                                              ],
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                                          child: const Text("Approve"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            showConfirmDialog(
                                              context,
                                              titleConfirm: "Disapprove",
                                              descriptionConfirm: "Are you sure for disapprove ?",
                                              action: [
                                                TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    showLoadingDialog(context);
                                                    await widget.prov.disapproved(widget.dataNotif, item.id, widget.module).then((value) async {
                                                      Navigator.pop(context);
                                                      if (value.theme == "success") {
                                                        showLoadingDialog(context);
                                                        notifC.fetchNotification();
                                                        // permitC.fetchPermit(permitC.initDate.year);
                                                        Navigator.pop(context);
                                                        showInfoSnackbar(context, value.message);
                                                      } else {
                                                        showFailSnackbar(context, value.message);
                                                      }
                                                    });
                                                  },
                                                  child: const Text("Yes"),
                                                ),
                                              ],
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
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
            widget.prov.selectAll == true
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
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                              onPressed: () {
                                showConfirmDialog(
                                  context,
                                  titleConfirm: "Approve All",
                                  descriptionConfirm: "Are you sure for approve all ?",
                                  action: [
                                    TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        showLoadingDialog(context);
                                        await widget.prov.approvedAll(dataNotif: widget.dataNotif, module: widget.module).then((value) async {
                                          Navigator.pop(context);
                                          if (value.theme == "success") {
                                            showLoadingDialog(context);
                                            notifC.fetchNotification();
                                            // permitC.fetchPermit(permitC.initDate.year);
                                            Navigator.pop(context);
                                            showInfoSnackbar(context, value.message);
                                          } else {
                                            showFailSnackbar(context, value.message);
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
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                              onPressed: () {
                                showConfirmDialog(
                                  context,
                                  titleConfirm: "Disapprove All",
                                  descriptionConfirm: "Are you sure for diaspprove all ?",
                                  action: [
                                    TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        showLoadingDialog(context);
                                        await widget.prov.disapprovedAll(dataNotif: widget.dataNotif, module: widget.module).then((value) async {
                                          Navigator.pop(context);
                                          if (value.theme == "success") {
                                            showLoadingDialog(context);
                                            notifC.fetchNotification();
                                            // permitC.fetchPermit(permitC.initDate.year);
                                            Navigator.pop(context);
                                            showInfoSnackbar(context, value.message);
                                          } else {
                                            showFailSnackbar(context, value.message);
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
      },
    );
  }
}

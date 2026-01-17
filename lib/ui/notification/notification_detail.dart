import 'package:easy_hris/ui/notification/widgets/change_days_notification_widget.dart';
import 'package:easy_hris/ui/notification/widgets/overtime_notification_widget.dart';
import 'package:easy_hris/ui/notification/widgets/permit_notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../data/models/notifications/notification_response.dart';
import '../../providers/notifications/notification_detail_provider.dart';
import '../util/widgets/app_bar_custom.dart';
import '../util/widgets/data_not_found.dart';

class NotificationDetail extends StatelessWidget {
  const NotificationDetail({super.key, required this.dataNotif});

  final ResultNotif dataNotif;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationDetailProvider(dataNotif: dataNotif),
      child: Scaffold(
        appBar: appBarCustom(
          context,
          title: "Approval",
          leadingBack: true,
          action: [
            Consumer<NotificationDetailProvider>(
              builder: (context, prov, _) {
                return TextButton(onPressed: prov.setSelectAll, child: const Text("Select All"));
              },
            ),
          ],
        ),
        body: Consumer<NotificationDetailProvider>(
          builder: (context, prov, child) {
            switch (prov.resultStatus) {
              case ResultStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ResultStatus.noData:
                return const DataEmpty(dataName: "Data Notification");
              case ResultStatus.hasData:
                {
                  switch (dataNotif.module) {
                    case "change_days":
                      return ChangeDaysNotificationWidget(
                        dataItem: prov.detailChangeDays,
                        prov: prov,
                        module: dataNotif.module,
                        dataNotif: dataNotif,
                      );
                    case "permits":
                      return PermitNotificationWidget(dataItem: prov.detailPermit, prov: prov, module: dataNotif.module, dataNotif: dataNotif);
                    default:
                      return OvertimeNotificationWidget(dataItem: prov.detailOvertime, prov: prov, module: dataNotif.module, dataNotif: dataNotif);
                  }
                }

              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}

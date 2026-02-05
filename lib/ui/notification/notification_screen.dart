import 'package:animate_do/animate_do.dart';
import 'package:easy_hris/data/models/response/notification_model.dart';
import 'package:easy_hris/ui/notification/widgets/item_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constant/constant.dart';
import '../../data/models/notifications/notification_response.dart';
import '../../providers/notifications/notification_provider.dart';
import '../util/widgets/app_bar_custom.dart';
import '../util/widgets/card_info.dart';
import '../util/widgets/data_empty.dart';
import '../util/widgets/shimmer_list_load_data.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationProvider(),
      child: Scaffold(
        appBar: AppbarCustom.appbar(context, title: "Notification", leadingBack: true),
        body: Consumer<NotificationProvider>(
          builder: (context, prov, _) {
            switch (prov.resultStatus) {
              case ResultStatus.loading:
                return const ShimmerListLoadData();
              case ResultStatus.noData:
                return const DataEmpty(dataName: "Notification");
              case ResultStatus.error:
                return Center(child: Text(prov.message));
              case ResultStatus.hasData:
                return SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () => prov.fetchNotification(),
                    child: ListView.builder(
                      itemCount: prov.listNotification.length,
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      itemBuilder: (context, index) {
                        final item = prov.listNotification[index];
                        final relativeTime = Intl.message(timeago.format(item.createdDate), args: [item.createdDate], locale: 'en');
                        return ItemNotification(item: item, dateNotif: relativeTime);
                      },
                    ),
                  ),
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}

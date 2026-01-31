import 'package:animate_do/animate_do.dart';
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
import '../util/widgets/data_not_found.dart';
import '../util/widgets/shimmer_list_load_data.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NotificationProvider>(context, listen: false).fetchNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom.appbar(context, title: "Notification", leadingBack: true),
      body: Consumer<NotificationProvider>(
        builder: (context, prov, _) {
          switch (prov.resultStatus) {
            case ResultStatus.loading:
              return const ShimmerListLoadData();
            case ResultStatus.noData:
              return const DataEmpty(dataName: "Notification");
            case ResultStatus.error:
              return FadeInUp(
                child: Center(
                  child: CardInfo(
                    iconData: Iconsax.info_circle_outline,
                    colorIcon: Colors.red,
                    title: "Error",
                    description: prov.message,
                    onPressed: () {
                      prov.fetchNotification();
                    },
                    titleButton: "Refresh",
                    colorTitle: Colors.red,
                    buttonStyle: ElevatedButton.styleFrom(backgroundColor: ConstantColor.colorBlueDark, foregroundColor: Colors.white),
                  ),
                ),
              );
            case ResultStatus.hasData:
              return RefreshIndicator(
                onRefresh: () => prov.fetchNotification(),
                child: ListView.builder(
                  itemCount: prov.listNotification.length,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  itemBuilder: (context, index) {
                    ResultNotif result = prov.listNotification[index];
                    final dateTime = DateTime.parse(result.createdDate);
                    final relativeTime = Intl.message(timeago.format(dateTime), args: [dateTime], locale: 'en');
                    return ItemNotification(dataItem: result, dateNotif: relativeTime, imgUrl: result.avatar);
                  },
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}

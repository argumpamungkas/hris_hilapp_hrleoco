import 'package:easy_hris/data/models/response/notification_model.dart';
import 'package:easy_hris/ui/util/widgets/image_network_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/routes.dart';
import '../../../providers/preferences_provider.dart';

class ItemNotification extends StatelessWidget {
  const ItemNotification({super.key, required this.item, required this.dateNotif});

  final NotificationModel item;
  final String dateNotif;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Card(
            child: ListTile(
              onTap: () => Navigator.pushNamed(context, Routes.notificationDetailScreen, arguments: item),
              leading: Container(
                width: 42.w,
                height: 42.h,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ImageNetworkCustom(url: item.avatar ?? ''),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: prov.isDarkTheme ? Colors.white : Colors.grey.shade600),
                  ),
                  Html(
                    data: item.description ?? '',
                    style: {
                      "body": Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        fontSize: FontSize(12.sp),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    },
                  ),
                  Text(
                    dateNotif,
                    style: TextStyle(fontSize: 9.sp, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

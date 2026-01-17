import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/routes.dart';
import '../../../data/models/notifications/notification_response.dart';
import '../../../providers/preferences_provider.dart';

class ItemNotification extends StatelessWidget {
  const ItemNotification({super.key, required this.dataItem, required this.dateNotif, required this.imgUrl});

  final ResultNotif dataItem;
  final String dateNotif, imgUrl;

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
    return Card(
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, Routes.notificationDetailScreen, arguments: dataItem),
        leading: Container(
          width: 42.w,
          height: 42.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                dateNotif,
                style: TextStyle(fontSize: 8.sp, fontStyle: FontStyle.italic),
              ),
            ),
            Text(
              dataItem.fullname,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: prov.isDarkTheme ? Colors.white : Colors.grey.shade600),
            ),
            Text(
              dataItem.message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10.sp, color: prov.isDarkTheme ? Colors.white : Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

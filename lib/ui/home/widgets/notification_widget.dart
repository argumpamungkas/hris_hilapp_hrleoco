import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../constant/routes.dart';
import '../../../providers/notifications/notification_provider.dart';
import '../../util/utils.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4.w,
          children: [
            Image.asset(Constant.logo, filterQuality: FilterQuality.high, width: 0.3.sw, color: Colors.white),
            Text(
              Constant.appVersion,
              style: TextStyle(fontSize: 9.sp, color: Colors.grey.shade200, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            IconButton(
              onPressed: () async {
                // Navigator.pushNamed(context, Routes.notificationScreen);
                showInfoSnackbar(context, "Feature on Progress");
              },
              icon: const Icon(Icons.notifications_none_outlined),
              color: Colors.white,
              iconSize: 22.w.h,
            ),
            Consumer<NotificationProvider>(
              builder: (context, prov, _) {
                switch (prov.resultStatus) {
                  case ResultStatus.loading:
                    return Container();
                  case ResultStatus.noData:
                    return valueNotification(prov.total);
                  case ResultStatus.hasData:
                    return valueNotification(prov.total);
                  default:
                    return Container();
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget valueNotification(int value) {
    return Visibility(
      visible: value == 0 ? false : true,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        margin: EdgeInsets.only(left: 12.w, top: 4.h),
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        child: Text(
          "$value",
          style: TextStyle(color: Colors.white, fontSize: 8.sp),
        ),
      ),
    );
  }
}

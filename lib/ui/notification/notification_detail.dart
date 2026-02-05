import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/response/notification_model.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/util/widgets/image_network_custom.dart';
import 'package:easy_hris/ui/util/widgets/item_detail_transaction.dart';
import 'package:easy_hris/ui/util/widgets/item_info_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/widgets/app_bar_custom.dart';

class NotificationDetail extends StatelessWidget {
  const NotificationDetail({super.key, required this.item});

  final NotificationModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom.appbar(context, title: "Notification Detail", leadingBack: true),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(12.w),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                // margin: EdgeInsets.all(12.w),
                child: Column(
                  children: [
                    Row(
                      spacing: 12.w,
                      children: [
                        Container(
                          width: 42.w,
                          height: 42.h,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ImageNetworkCustom(url: item.avatar ?? ''),
                        ),
                        Expanded(
                          child: Consumer<PreferencesProvider>(
                            builder: (context, prov, _) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    item.name ?? '',
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    item.position ?? '',
                                    style: TextStyle(fontSize: 12.sp, color: prov.isDarkTheme ? Colors.white : Colors.grey),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Card(
                margin: EdgeInsets.all(12.w),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                  child: Column(
                    spacing: 12.h,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Text(
                          "Information & Detail",
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                        ),
                      ),

                      Expanded(
                        child: ListView.builder(
                          itemCount: item.details.length,
                          itemBuilder: (context, index) {
                            final itemDetail = item.details[index];
                            return ItemDetailTransaction(
                              title: itemDetail.description ?? '',
                              value: itemDetail.value ?? '',
                              isFIle: itemDetail.description!.toLowerCase().contains('image') ? true : false,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

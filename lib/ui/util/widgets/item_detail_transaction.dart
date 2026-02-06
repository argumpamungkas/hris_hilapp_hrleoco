import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/routes.dart';
import '../utils.dart';

class ItemDetailTransaction extends StatelessWidget {
  const ItemDetailTransaction({super.key, required this.title, required this.value, this.isFIle = false});

  final String title, value;
  final bool isFIle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
            Expanded(
              child: isFIle
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Consumer<PreferencesProvider>(
                        builder: (context, prov, _) {
                          return InkWell(
                            onTap: () {
                              String url = '';

                              if (value.isEmpty) {
                                showFailSnackbar(context, "${title.toUpperCase()} doesn't have photo");
                                return;
                              }

                              final itemName = title.toLowerCase();
                              if (itemName.contains('kk')) {
                                url = "${prov.baseUrl}/${Constant.urlProfileKk}/$value";
                              } else if (itemName.contains('npwp')) {
                                url = "${prov.baseUrl}/${Constant.urlProfileNpwp}/$value";
                              } else if (itemName.contains('profile')) {
                                url = "${prov.baseUrl}/${Constant.urlProfileImage}/$value";
                              } else if (itemName.toLowerCase().contains('attachment')) {
                                url = "${prov.baseUrl}/${Constant.urlPermits}/$value";
                              } else {
                                url = "${prov.baseUrl}/${Constant.urlProfileKtp}/$value";
                              }

                              Navigator.pushNamed(context, Routes.viewImageNetworkScreen, arguments: url);
                            },
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.w),
                                border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                              ),
                              child: Icon(Icons.visibility, size: 16.w),
                            ),
                          );
                        },
                      ),
                    )
                  : Text(
                      value,
                      textAlign: TextAlign.end,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                    ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}

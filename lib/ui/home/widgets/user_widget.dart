import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/util/widgets/image_network_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth/profile_provider.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfileProvider, PreferencesProvider>(
      builder: (context, prov, provPref, _) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Row(
            spacing: 12,
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(height: 42, width: 42, child: ImageNetworkCustom(url: "${provPref.baseUrl}/${Constant.urlDefaultImage}")),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${prov.greetingCondition},",
                      style: TextStyle(fontWeight: FontWeight.bold, color: provPref.isDarkTheme ? Colors.white : Colors.grey, fontSize: 10.sp),
                    ),
                    Text(
                      prov.userModel?.name?.toUpperCase() ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold, color: provPref.isDarkTheme ? Colors.white : Colors.black, fontSize: 12.sp),
                    ),
                    Text(
                      prov.userModel?.position?.toUpperCase() ?? "",
                      style: TextStyle(fontSize: 9.sp, color: provPref.isDarkTheme ? Colors.white : Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

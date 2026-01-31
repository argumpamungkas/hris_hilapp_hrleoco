import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/providers/home_provider.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/util/widgets/image_network_custom.dart';
import 'package:flutter/cupertino.dart';
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
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, ${prov.userModel?.name?.toUpperCase()}",
                      style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 12.sp),
                    ),
                    Text(
                      prov.greetingCondition,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.sp),
                    ),
                  ],
                ),
              ),

              Consumer<HomeProvider>(
                builder: (context, homeProv, _) {
                  if (homeProv.resultStatusAttendanceToday == ResultStatus.loading) {
                    return CupertinoActivityIndicator();
                  }

                  return SizedBox(
                    height: 54.h,
                    width: 54.w,
                    child: ClipOval(
                      child: ImageNetworkCustom(
                        isFit: true,
                        url: homeProv.shiftUserModel?.imageProfile != null && homeProv.shiftUserModel!.imageProfile!.isNotEmpty
                            ? "${provPref.baseUrl}/${Constant.urlProfileImage}/${homeProv.shiftUserModel!.imageProfile}"
                            : "${provPref.baseUrl}/${Constant.urlDefaultImage}",
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/home/widgets/card_home_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';
import '../../../constant/exports.dart';
import '../../../providers/auth/profile_provider.dart';
import '../../../providers/home_provider.dart';
import '../../util/widgets/image_network_custom.dart';

class PermissionContainer extends StatelessWidget {
  const PermissionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CardHomeCustom(
      title: "Permission Today",
      subtitle: "Some employees are absent today",
      widget: Consumer3<HomeProvider, ProfileProvider, PreferencesProvider>(
        builder: (context, homeProv, provProfile, provPref, _) {
          if (homeProv.resultStatusAttendanceToday == ResultStatus.loading) {
            return CupertinoActivityIndicator();
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      spacing: 12.w,
                      children: [
                        SizedBox(
                          height: 32.h,
                          width: 32.w,
                          child: ClipOval(
                            child: ImageNetworkCustom(
                              isFit: true,
                              url: homeProv.shiftUserModel?.imageProfile != null && homeProv.shiftUserModel!.imageProfile!.isNotEmpty
                                  ? "${provPref.baseUrl}/${Constant.urlProfileImage}/${homeProv.shiftUserModel!.imageProfile}"
                                  : "${provPref.baseUrl}/${Constant.urlDefaultImage}",
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Agung Gumilar",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                              ),
                              Text("CUTI - Acara Keluarga", style: TextStyle(fontSize: 11.sp)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

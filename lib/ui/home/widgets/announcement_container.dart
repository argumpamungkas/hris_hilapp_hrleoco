import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/home/widgets/card_home_custom.dart';
import 'package:easy_hris/ui/util/widgets/loading_shimmer_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';
import '../../../constant/exports.dart';
import '../../../providers/auth/profile_provider.dart';
import '../../../providers/home_provider.dart';
import '../../util/widgets/image_network_custom.dart';

class AnnouncementContainer extends StatelessWidget {
  const AnnouncementContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CardHomeCustom(
      title: "Announcement",
      subtitle: "There is an announcement from HR for you",
      widget: Consumer3<HomeProvider, ProfileProvider, PreferencesProvider>(
        builder: (context, homeProv, provProfile, provPref, _) {
          switch (homeProv.resultStatusAttendanceToday) {
            case ResultStatus.loading:
              return LoadingShimmerCard();
            case ResultStatus.hasData:
              return ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(height: 8.h),
                        Text(
                          "Office Closure - Imlek Days",
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          ConstantMessage.loremIpsumText,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.sp),
                        ),

                        SizedBox(height: 8.h),

                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(color: ConstantColor.bgIcon, borderRadius: BorderRadius.circular(8.w)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 4.w,
                            children: [
                              Icon(Icons.file_present, size: 14.w),
                              Text("Attachment", style: TextStyle(fontSize: 10.sp)),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              );
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

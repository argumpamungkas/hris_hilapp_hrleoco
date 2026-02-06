import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/home/widgets/card_home_custom.dart';
import 'package:easy_hris/ui/home/widgets/error_home_custom.dart';
import 'package:easy_hris/ui/util/utils.dart';
import 'package:easy_hris/ui/util/widgets/loading_shimmer_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
            case ResultStatus.error:
              return SizedBox(
                width: 1.w,
                child: ErrorHomeCustom(
                  message: homeProv.messageAnnouncement,
                  onPressed: () {
                    homeProv.fetchAnnouncement();
                  },
                ),
              );
            case ResultStatus.noData:
              return ErrorHomeCustom(message: homeProv.messageAnnouncement, onPressed: null, isRefresh: false);
            case ResultStatus.hasData:
              return ListView.builder(
                shrinkWrap: true,
                itemCount: homeProv.listAnnouncement.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = homeProv.listAnnouncement[index];

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
                                  url: item?.imageProfile != null && item.imageProfile!.isNotEmpty
                                      ? "${provPref.baseUrl}/${Constant.urlProfileImage}/${item.imageProfile}"
                                      : "${provPref.baseUrl}/${Constant.urlDefaultImage}",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name ?? '',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                                  ),
                                  Text(item.positionName ?? '', style: TextStyle(fontSize: 11.sp)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          item.title ?? '',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item.displayDate ?? '',
                          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                        ),
                        SizedBox(height: 4.h),

                        Html(
                          data: item.description ?? '',
                          style: {
                            "body": Style(
                              margin: Margins.zero,
                              padding: HtmlPaddings.zero,
                              fontSize: FontSize(12.sp),
                              maxLines: 3,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          },
                        ),

                        SizedBox(height: 8.h),

                        Visibility(
                          visible: item.attachment!.isEmpty ? false : true,
                          child: InkWell(
                            onTap: () {
                              showInfoSnackbar(context, "Download on progress");
                              homeProv.prepareSaveDir(item, index);
                            },
                            child: Container(
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

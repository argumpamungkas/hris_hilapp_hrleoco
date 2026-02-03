import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/home/widgets/card_home_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';
import '../../../constant/exports.dart';
import '../../../providers/auth/profile_provider.dart';
import '../../../providers/home_provider.dart';
import '../../util/widgets/card_employee_custom.dart';
import '../../util/widgets/loading_shimmer_card.dart';
import 'error_home_custom.dart';

class PermissionContainer extends StatelessWidget {
  const PermissionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CardHomeCustom(
      title: "Permission Today",
      subtitle: "Some employees are absent today",
      widget: Consumer3<HomeProvider, ProfileProvider, PreferencesProvider>(
        builder: (context, homeProv, provProfile, provPref, _) {
          switch (homeProv.resultStatusPermitToday) {
            case ResultStatus.loading:
              return LoadingShimmerCard();
            case ResultStatus.error:
              return SizedBox(
                width: 1.w,
                child: ErrorHomeCustom(
                  message: homeProv.messageAttendanceSummary,
                  onPressed: () {
                    homeProv.fetchAttendanceSummary();
                  },
                ),
              );
            case ResultStatus.noData:
              return ErrorHomeCustom(message: homeProv.messagePermitToday, onPressed: null, isRefresh: false);
            case ResultStatus.hasData:
              return ListView.builder(
                shrinkWrap: true,
                itemCount: homeProv.listPermitToday.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = homeProv.listPermitToday[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CardEmployeeCustom(
                          imageUrl: homeProv.shiftUserModel?.imageProfile != null && homeProv.shiftUserModel!.imageProfile!.isNotEmpty
                              ? "${provPref.baseUrl}/${Constant.urlProfileImage}/${item.imageProfile}"
                              : "${provPref.baseUrl}/${Constant.urlDefaultImage}",
                          title: item.name ?? '',
                          subtitle: "${item.permitName} - ${item.note}",
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

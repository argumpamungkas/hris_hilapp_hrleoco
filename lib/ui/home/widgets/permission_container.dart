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

class PermissionContainer extends StatelessWidget {
  const PermissionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CardHomeCustom(
      title: "Permission Today",
      subtitle: "Some employees are absent today",
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CardEmployeeCustom(
                          imageUrl: homeProv.shiftUserModel?.imageProfile != null && homeProv.shiftUserModel!.imageProfile!.isNotEmpty
                              ? "${provPref.baseUrl}/${Constant.urlProfileImage}/${homeProv.shiftUserModel!.imageProfile}"
                              : "${provPref.baseUrl}/${Constant.urlDefaultImage}",
                          title: "Agung Gumilar",
                          subtitle: "CUTI - acara keluarga",
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

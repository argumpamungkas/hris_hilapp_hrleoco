import 'package:animate_do/animate_do.dart';
import 'package:easy_hris/ui/team/widgets/item_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../data/models/teams.dart';
import '../../providers/preferences_provider.dart';
import '../../providers/team_provider.dart';
import '../util/widgets/app_bar_custom.dart';
import '../util/widgets/card_info.dart';
import '../util/widgets/data_not_found.dart';
import '../util/widgets/shimmer_list_load_data.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom.appbar(context, title: "Teams", leadingBack: false),
      body: Center(child: Text("Feature on Progress")),
      // body: Consumer2<TeamProvider, PreferencesProvider>(
      //   builder: (context, provTeam, provPref, _) {
      //     switch (provTeam.resultStatus) {
      //       case ResultStatus.loading:
      //         return const ShimmerListLoadData();
      //       case ResultStatus.noData:
      //         return const DataEmpty(dataName: "Teams");
      //       case ResultStatus.error:
      //         return FadeInUp(
      //           child: Center(
      //             child: CardInfo(
      //               iconData: Iconsax.info_circle_outline,
      //               colorIcon: Colors.red,
      //               title: "Error",
      //               description: provTeam.message,
      //               onPressed: () {
      //                 provTeam.fetchTeams();
      //               },
      //               titleButton: "Refresh",
      //               colorTitle: Colors.red,
      //               buttonStyle: ElevatedButton.styleFrom(backgroundColor: ConstantColor.colorBlueDark, foregroundColor: Colors.white),
      //             ),
      //           ),
      //         );
      //       case ResultStatus.hasData:
      //         return RefreshIndicator(
      //           onRefresh: () async {
      //             provTeam.fetchTeams();
      //           },
      //           child: ListView.builder(
      //             itemCount: provTeam.listTeam.length,
      //             padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      //             itemBuilder: (context, index) {
      //               ResultTeams teams = provTeam.listTeam[index];
      //               return Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Padding(
      //                     padding: EdgeInsets.only(left: 4.w),
      //                     child: Text(
      //                       teams.position,
      //                       style: TextStyle(
      //                         color: provPref.isDarkTheme ? Colors.white : Colors.grey.shade700,
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 14.sp,
      //                       ),
      //                     ),
      //                   ),
      //                   SizedBox(height: 4.h),
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: teams.details
      //                         .map(
      //                           (detail) => ItemTeam(
      //                             name: detail.name,
      //                             telp: detail.telp,
      //                             yearsWork: detail.services,
      //                             employeeId: detail.employeeId,
      //                             imgUrl: "${provTeam.linkServer}${detail.avatar}",
      //                             dateSign: detail.dateSign,
      //                           ),
      //                         )
      //                         .toList(),
      //                   ),
      //                   SizedBox(height: 8.h),
      //                 ],
      //               );
      //             },
      //           ),
      //         );
      //       default:
      //         return Container();
      //     }
      //   },
      // ),
    );
  }
}

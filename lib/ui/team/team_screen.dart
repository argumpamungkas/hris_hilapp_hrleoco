import 'package:animate_do/animate_do.dart';
import 'package:easy_hris/providers/auth/profile_provider.dart';
import 'package:easy_hris/ui/home/widgets/error_home_custom.dart';
import 'package:easy_hris/ui/team/widgets/item_team.dart';
import 'package:easy_hris/ui/util/widgets/card_custom_icon.dart';
import 'package:easy_hris/ui/util/widgets/card_employee_custom.dart';
import 'package:easy_hris/ui/util/widgets/card_info_custom.dart';
import 'package:flutter/cupertino.dart';
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
import '../util/widgets/data_empty.dart';
import '../util/widgets/image_network_custom.dart';
import '../util/widgets/shimmer_list_load_data.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TeamProvider(),
      child: Scaffold(
        appBar: AppbarCustom.appbar(context, title: "My Teams", leadingBack: false),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              spacing: 8.h,
              children: [
                CardInfoCustom(value: "The data below is employee data with some department"),
                Expanded(
                  child: Consumer2<TeamProvider, PreferencesProvider>(
                    builder: (context, prov, provPref, _) {
                      switch (prov.resultStatus) {
                        case ResultStatus.loading:
                          return const ShimmerListLoadData();

                        case ResultStatus.error:
                          return ErrorHomeCustom(
                            message: prov.message,
                            onPressed: () {
                              prov.fetchTeams();
                            },
                          );
                        case ResultStatus.noData:
                          return DataEmpty(dataName: "My Team");
                        case ResultStatus.hasData:
                          return Column(
                            spacing: 8.h,
                            children: [
                              Card(
                                child: TextField(
                                  controller: prov.searchC,
                                  decoration: InputDecoration(
                                    hintText: "Search Employee Name",
                                    // suffixIcon: Icon(prov.isFilter ? Icons.close : Icons.filter_alt),
                                    suffixIcon: prov.isFilter
                                        ? IconButton(
                                            onPressed: () {
                                              prov.onChangeIsSearch(false);
                                            },
                                            icon: Icon(Icons.close),
                                          )
                                        : null,
                                  ),
                                  onTap: () {
                                    prov.onChangeIsSearch(true);
                                  },
                                  onChanged: (value) {
                                    prov.onSearch(value);
                                  },
                                ),
                              ),

                              Expanded(
                                child: ListView.builder(
                                  itemCount: prov.isFilter ? prov.listTeamFilter.length : prov.listTeam.length,
                                  itemBuilder: (context, index) {
                                    final item = prov.listTeam[index];

                                    return Card(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.w),
                                        child: CardEmployeeCustom(
                                          imageUrl: item.imageProfile != null && item.imageProfile!.isNotEmpty
                                              ? "${provPref.baseUrl}/${Constant.urlProfileImage}/${item.imageProfile}"
                                              : "${provPref.baseUrl}/${Constant.urlDefaultImage}",
                                          title: item.name ?? '',
                                          subtitle: item.positionName ?? '',
                                          trailing: InkWell(
                                            onTap: () {},
                                            child: Icon(Iconsax.more_circle_bold, color: ConstantColor.colorBlue),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        default:
                          return SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

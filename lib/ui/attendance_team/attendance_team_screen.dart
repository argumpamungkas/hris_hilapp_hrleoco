import 'package:easy_hris/ui/attendance_team/widgets/item_day_off.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../data/models/days_off.dart';
import '../../providers/preferences_provider.dart';
import '../util/widgets/app_bar_custom.dart';
import '../util/widgets/data_not_found.dart';
import '../util/widgets/shimmer_list_load_data.dart';
import 'controller/day_off_controller.dart';

class AttendanceTeam extends StatelessWidget {
  const AttendanceTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(
        context,
        title: "Attendance Team",
        leadingBack: true,
        action: [
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => dialogFilter(context));
            },
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: Consumer2<AttendanceTeamController, PreferencesProvider>(
        builder: (context, prov, provPref, _) {
          switch (prov.resultStatus) {
            case ResultStatus.loading:
              return const ShimmerListLoadData();
            case ResultStatus.noData:
              return const DataEmpty(dataName: "Attendance Team");
            case ResultStatus.hasData:
              return Column(
                children: [
                  prov.searchFiltered
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          margin: const EdgeInsets.all(8),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Material(
                              borderRadius: BorderRadius.circular(16),
                              color: provPref.isDarkTheme ? Colors.black : Colors.grey.shade300,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                splashColor: Colors.grey,
                                onTap: () {
                                  prov.clearFilter();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                  child: const Text("Clear Filter X", style: TextStyle(fontSize: 8)),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shrinkWrap: true,
                      itemCount: prov.searchFiltered ? prov.listFilter.length : prov.listDaysOff.length,
                      itemBuilder: (context, index) {
                        ResultsDaysOff daysOff = prov.searchFiltered ? prov.listFilter[index] : prov.listDaysOff[index];
                        return Column(
                          children: [
                            ItemDayOff(urlImage: "${prov.linkServer}/${daysOff.image}", results: daysOff),
                            const SizedBox(height: 4),
                            const Divider(thickness: 1, height: 0),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}

Widget dialogFilter(BuildContext context) {
  AttendanceTeamController attendanceC = Provider.of<AttendanceTeamController>(context, listen: false);
  PreferencesProvider provPref = Provider.of<PreferencesProvider>(context, listen: false);
  late Color colorStatus;
  return AlertDialog(
    title: const Text("Filter"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: attendanceC.listFilterValue.map((filter) {
        if (filter['color'] == "blue") {
          colorStatus = Colors.blueAccent;
        } else if (filter['color'] == "green") {
          colorStatus = Colors.greenAccent.shade700;
        } else if (filter['color'] == "orange") {
          colorStatus = Colors.orangeAccent;
        } else {
          colorStatus = Colors.redAccent;
        }
        return Column(
          children: [
            ListTile(
              style: ListTileStyle.list,
              title: Text(filter['title']),
              titleTextStyle: TextStyle(color: provPref.isDarkTheme ? Colors.white : Colors.black),
              onTap: () {
                attendanceC.filterData(filter['color']);
                Navigator.pop(context);
              },
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CircleAvatar(backgroundColor: colorStatus, maxRadius: 4),
              ),
            ),
            const Divider(height: 1, thickness: 1),
          ],
        );
      }).toList(),
    ),
  );
}

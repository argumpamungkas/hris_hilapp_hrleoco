import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../constant/routes.dart';
import '../../../data/models/days_off.dart';
import '../../../providers/preferences_provider.dart';
import '../../attendance_team/controller/day_off_controller.dart';
import '../../util/widgets/data_not_found.dart';
import 'loading_list.dart';

class ListViewAttendanceTeam extends StatefulWidget {
  const ListViewAttendanceTeam({super.key, required this.access});

  final String access;

  @override
  State<ListViewAttendanceTeam> createState() => _ListViewAttendanceTeamState();
}

class _ListViewAttendanceTeamState extends State<ListViewAttendanceTeam> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.access != "LIMITED") {
        Provider.of<AttendanceTeamController>(context, listen: false).fetchDaysOff();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AttendanceTeamController, PreferencesProvider>(
      builder: (context, prov, provPref, _) {
        switch (prov.resultStatus) {
          case ResultStatus.loading:
            return const LoadingList();
          case ResultStatus.error:
            return Center(child: Text(prov.message));
          case ResultStatus.noData:
            return Card(
              color: provPref.isDarkTheme ? Colors.black : Colors.white,
              surfaceTintColor: provPref.isDarkTheme ? Colors.black : Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.w.h),
                child: const DataEmpty(dataName: "Attendance Team"),
              ),
            );
          case ResultStatus.hasData:
            return Card(
              color: provPref.isDarkTheme ? Colors.black : Colors.white,
              surfaceTintColor: provPref.isDarkTheme ? Colors.black : Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.w.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Text(
                              "Attendance Team",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: provPref.isDarkTheme ? Colors.white : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.attendanceTeamScreen);
                            },
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(color: Colors.blue, fontSize: 12.sp),
                            ),
                            child: const Text("View All"),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: prov.listDaysOff.length <= 5 ? prov.listDaysOff.length : 5,
                      itemBuilder: (context, index) {
                        ResultsDaysOff results = prov.listDaysOff[index];
                        late Color colorDesc;
                        if (results.color.toUpperCase() == "GREEN") {
                          colorDesc = Colors.greenAccent.shade400;
                        } else if (results.color.toUpperCase() == "BLUE") {
                          colorDesc = Colors.blueAccent;
                        } else if (results.color.toUpperCase() == "ORANGE") {
                          colorDesc = Colors.orangeAccent;
                        } else {
                          colorDesc = Colors.redAccent;
                        }
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.teamsDetailScreen,
                                  arguments: {
                                    "employeeId": results.employeeId,
                                    "name": results.name,
                                    "imageUrl": "${prov.linkServer}${results.image}",
                                    "yearsWork": results.services,
                                    "dateSign": results.dateSign,
                                  },
                                );
                              },
                              visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                              leading: Container(
                                width: 42.w,
                                height: 42.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: NetworkImage("${prov.linkServer}${results.image}"), fit: BoxFit.cover),
                                ),
                              ),
                              title: Text(results.name),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.access_time_rounded, size: 14.sp, color: Colors.green),
                                        SizedBox(width: 2.h),
                                        Text(results.timeIn != null || results.timeIn! != "" ? results.timeIn! : "-"),
                                      ],
                                    ),
                                    SizedBox(width: 8.w),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.access_time_rounded, size: 14.sp, color: Colors.red),
                                        SizedBox(width: 4.w),
                                        Text(results.timeOut != null || results.timeOut! != "" ? results.timeOut! : "-"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(color: colorDesc, borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  results.description,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 8.sp),
                                ),
                              ),
                            ),
                            SizedBox(height: 2.sp),
                            const Divider(thickness: 1, height: 0),
                            SizedBox(height: 4.h),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );

          default:
            return Container();
        }
      },
    );

    // FutureBuilder(
    //   future: _homeC.fetchDaysOff(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Shimmer.fromColors(
    //         baseColor: Colors.grey.shade300,
    //         highlightColor: Colors.white,
    //         child: Card(
    //           color: Colors.white,
    //           child: Container(
    //             height: 80,
    //           ),
    //         ),
    //       );
    //     }

    //     if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //       return Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             "Days Off",
    //             style: TextStyle(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.grey.shade600,
    //             ),
    //           ),
    //           const DataNotFound(dataName: "Days Off"),
    //         ],
    //       );
    //     }

    //     return Column(
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               "Days Off",
    //               style: TextStyle(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.grey.shade600,
    //               ),
    //             ),
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.pushNamed(
    //                   context,
    //                   DaysOffScreen.routeName,
    //                 );
    //               },
    //               style: TextButton.styleFrom(
    //                 textStyle: const TextStyle(
    //                   color: Colors.blue,
    //                 ),
    //               ),
    //               child: const Text("View All"),
    //             ),
    //           ],
    //         ),
    //         ListView.builder(
    //           shrinkWrap: true,
    //           physics: const NeverScrollableScrollPhysics(),
    //           itemCount: snapshot.data!.length <= 2 ? snapshot.data!.length : 2,
    //           itemBuilder: (context, index) {
    //             ResultsDaysOff results = snapshot.data![index];
    //             return Column(
    //               children: [
    //                 ListTile(
    //                   contentPadding: const EdgeInsets.only(
    //                     right: 8,
    //                   ),
    //                   visualDensity: const VisualDensity(
    //                     horizontal: VisualDensity.minimumDensity,
    //                     vertical: VisualDensity.minimumDensity,
    //                   ),
    //                   leading: Container(
    //                     width: 50,
    //                     height: 50,
    //                     margin: const EdgeInsets.only(right: 8),
    //                     decoration: BoxDecoration(
    //                       shape: BoxShape.circle,
    //                       image: DecorationImage(
    //                         image: NetworkImage("$_linkServer${results.image}"),
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   title: Text(
    //                     results.name,
    //                   ),
    //                   titleTextStyle: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.grey.shade600,
    //                   ),
    //                   subtitle: Text(
    //                     results.position,
    //                     style: TextStyle(
    //                       color: Colors.grey.shade600,
    //                       fontSize: 10,
    //                     ),
    //                   ),
    //                   trailing: Container(
    //                     padding: const EdgeInsets.all(4),
    //                     decoration: BoxDecoration(
    //                         color: results.permit == "SAKIT"
    //                             ? Colors.red
    //                             : Colors.amber,
    //                         borderRadius: BorderRadius.circular(8)),
    //                     child: Text(
    //                       results.permit,
    //                       style: const TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Divider(
    //                   thickness: 1,
    //                   height: 0,
    //                   indent: MediaQuery.of(context).size.width * 0.15,
    //                 ),
    //                 const SizedBox(height: 8),
    //               ],
    //             );
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}

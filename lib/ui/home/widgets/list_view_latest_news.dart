import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../constant/routes.dart';
import '../../../data/models/news.dart';
import '../../../providers/dashboard_provider.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/preferences_provider.dart';
import '../../util/widgets/data_not_found.dart';
import 'loading_list.dart';

class ListViewLatestNews extends StatelessWidget {
  const ListViewLatestNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<HomeProvider, PreferencesProvider, DashboardProvider>(
      builder: (context, prov, provPref, provDashboard, _) {
        switch (prov.resultStatus) {
          case ResultStatus.loading:
            return const LoadingList();
          case ResultStatus.hasData:
            return prov.listNews.isEmpty
                ? Card(
                    color: provPref.isDarkTheme ? Colors.black : Colors.white,
                    surfaceTintColor: provPref.isDarkTheme ? Colors.black : Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.w.h),
                      child: const DataEmpty(dataName: "News"),
                    ),
                  )
                : Card(
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
                                    "Latest News",
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
                                    provDashboard.changeScreen(1);
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
                            itemCount: prov.listNews.length <= 2 ? prov.listNews.length : 2,
                            itemBuilder: (context, index) {
                              ResultsNews results = prov.listNews[index];
                              return Column(
                                children: [
                                  ListTile(
                                    visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,
                                    ),
                                    onTap: () =>
                                        Navigator.pushNamed(context, Routes.newsDetailScreen, arguments: {"news": results, "link": prov.linkServer}),
                                    leading: Container(
                                      width: 42.w,
                                      height: 42.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(image: NetworkImage("${prov.linkServer}${results.avatar}"), fit: BoxFit.cover),
                                      ),
                                    ),
                                    title: Text(results.name),
                                    subtitle: Text(results.createdDate),
                                  ),
                                  SizedBox(height: 2.h),
                                  const Divider(thickness: 1, height: 0),
                                  SizedBox(height: 8.h),
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
  }
}

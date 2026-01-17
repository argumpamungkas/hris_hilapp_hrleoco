import 'package:animate_do/animate_do.dart';
import 'package:easy_hris/ui/news/widgets/item_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../data/models/news.dart';
import '../../providers/news/news_provider.dart';
import '../util/widgets/app_bar_custom.dart';
import '../util/widgets/card_info.dart';
import '../util/widgets/data_not_found.dart';
import '../util/widgets/shimmer_list_load_data.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, title: "News", leadingBack: false),
      body: Center(child: Text("Feature on Progress")),
      // body: SafeArea(
      //   child: Consumer<NewsProvider>(
      //     builder: (context, prov, child) {
      //       switch (prov.resultStatus) {
      //         case ResultStatus.loading:
      //           return const ShimmerListLoadData();
      //         case ResultStatus.noData:
      //           return const DataEmpty(dataName: "News");
      //         case ResultStatus.error:
      //           return FadeInUp(
      //             child: Center(
      //               child: CardInfo(
      //                 iconData: Iconsax.info_circle_outline,
      //                 colorIcon: Colors.red,
      //                 title: "Error",
      //                 description: prov.message,
      //                 onPressed: () {
      //                   prov.fetchNews();
      //                 },
      //                 titleButton: "Refresh",
      //                 colorTitle: Colors.red,
      //                 buttonStyle: ElevatedButton.styleFrom(backgroundColor: ConstantColor.colorBlueDark, foregroundColor: Colors.white),
      //               ),
      //             ),
      //           );
      //         case ResultStatus.hasData:
      //           return RefreshIndicator(
      //             onRefresh: () async {
      //               prov.fetchNews();
      //             },
      //             child: ListView.builder(
      //               padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      //               itemCount: prov.listNews.length,
      //               itemBuilder: (context, index) {
      //                 ResultsNews results = prov.listNews[index];
      //                 return Column(
      //                   children: [
      //                     ItemNews(
      //                       resultsNews: results,
      //                       link: prov.linkServer,
      //                       titleNews: results.name,
      //                       createdDate: results.createdDate,
      //                       imgUrl: "${prov.linkServer}${results.avatar}",
      //                     ),
      //                     SizedBox(height: 2.h),
      //                   ],
      //                 );
      //               },
      //             ),
      //           );
      //         default:
      //           return Container();
      //       }
      //     },
      //   ),
      // ),
    );
  }
}

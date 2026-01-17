import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/routes.dart';
import '../../../data/models/news.dart';

class ItemNews extends StatelessWidget {
  const ItemNews({
    super.key,
    required this.resultsNews,
    required this.link,
    required this.titleNews,
    required this.createdDate,
    required this.imgUrl,
  });

  final ResultsNews resultsNews;
  final String link;
  final String titleNews;
  final String createdDate;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, Routes.newsDetailScreen, arguments: {"news": resultsNews, "link": link}),
        leading: Container(
          width: 42.w,
          height: 42.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        title: Text(titleNews, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(createdDate, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

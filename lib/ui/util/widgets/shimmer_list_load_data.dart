import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../providers/preferences_provider.dart';

class ShimmerListLoadData extends StatelessWidget {
  const ShimmerListLoadData({super.key});

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
    return Shimmer.fromColors(
      baseColor: prov.isDarkTheme ? Colors.black87 : Colors.grey.shade300,
      highlightColor: prov.isDarkTheme ? Colors.grey.shade800 : Colors.white,
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
            child: Card(
              color: prov.isDarkTheme ? Colors.black87 : Colors.white,
              child: Container(height: 50.h),
            ),
          );
        },
      ),
    );
  }
}

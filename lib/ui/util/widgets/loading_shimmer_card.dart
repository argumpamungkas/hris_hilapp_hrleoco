import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmerCard extends StatelessWidget {
  const LoadingShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Shimmer.fromColors(
          baseColor: prov.isDarkTheme ? Colors.black87 : Colors.grey.shade300,
          highlightColor: prov.isDarkTheme ? Colors.grey.shade800 : Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
            child: Card(
              color: prov.isDarkTheme ? Colors.black87 : Colors.white,
              child: SizedBox(height: 100.h, width: 1.sw),
            ),
          ),
        );
      },
    );
    ;
  }
}

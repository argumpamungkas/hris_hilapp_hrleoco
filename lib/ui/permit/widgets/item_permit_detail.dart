import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/preferences_provider.dart';

class ItemPermitDetail extends StatelessWidget {
  const ItemPermitDetail({super.key, required this.titleItem, required this.dataItem});

  final String titleItem, dataItem;

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          titleItem,
          style: TextStyle(color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700, fontSize: 11.sp),
        ),
        Text(
          dataItem,
          style: TextStyle(color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700, fontWeight: FontWeight.bold, fontSize: 13.sp),
        ),
        SizedBox(height: 4.h),
        Divider(thickness: 1, height: 0, color: Colors.grey.shade300),
      ],
    );
  }
}

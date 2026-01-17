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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                titleItem,
                style: TextStyle(color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700, fontSize: 10.sp),
              ),
            ),
            Expanded(
              child: Text(
                dataItem,
                textAlign: TextAlign.end,
                style: TextStyle(color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700, fontWeight: FontWeight.bold, fontSize: 10.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Divider(thickness: 1, height: 0, color: Colors.grey.shade300),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/preferences_provider.dart';

class ItemDataNotification extends StatelessWidget {
  const ItemDataNotification({super.key, required this.title, required this.value});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(color: prov.isDarkTheme ? Colors.white : Colors.grey.shade600, fontSize: 10.sp),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      value,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: prov.isDarkTheme ? Colors.white : Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 10.sp),
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1, height: 4, color: Colors.grey.shade300),
            ],
          ),
        );
      },
    );
  }
}

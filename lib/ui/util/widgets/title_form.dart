import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/preferences_provider.dart';

class TitleForm extends StatelessWidget {
  const TitleForm({super.key, required this.textTitle});

  final String textTitle;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              textTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp, color: prov.isDarkTheme ? Colors.white : Colors.black),
            ),
            SizedBox(width: 2.w),
            const Text("*", style: TextStyle(color: Colors.red)),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/preferences_provider.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          padding: EdgeInsets.all(18.h.w),
          decoration: BoxDecoration(color: prov.isDarkTheme ? Colors.black : Colors.white, borderRadius: BorderRadius.circular(24.h.w)),
          child: child,
        );
      },
    );
  }
}

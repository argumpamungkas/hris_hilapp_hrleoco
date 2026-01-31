import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';

class BackgroundHome extends StatelessWidget {
  const BackgroundHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 0.3.sh,
      decoration: BoxDecoration(
        color: ConstantColor.colorBlue,
        // borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
      ),
    );
  }
}

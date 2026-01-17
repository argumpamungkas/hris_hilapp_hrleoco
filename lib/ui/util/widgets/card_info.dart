import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
    required this.iconData,
    required this.colorIcon,
    required this.title,
    required this.colorTitle,
    required this.description,
    required this.onPressed,
    required this.titleButton,
    this.buttonStyle,
  });

  final IconData iconData;
  final Color colorIcon, colorTitle;
  final String title, description, titleButton;
  final void Function()? onPressed;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Padding(
        padding: EdgeInsets.all(16.w.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: 24.h.w,
              color: colorIcon,
            ),
            SizedBox(height: 4.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: colorTitle,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              description,
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(height: 12.h),
            ElevatedButton(
              style: buttonStyle,
              onPressed: onPressed,
              child: Text(titleButton),
            ),
          ],
        ),
      ),
    );
  }
}

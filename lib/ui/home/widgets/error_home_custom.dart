import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class ErrorHomeCustom extends StatelessWidget {
  const ErrorHomeCustom({super.key, required this.message, required this.onPressed, this.isRefresh = true});

  final String message;
  final void Function()? onPressed;
  final bool isRefresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Center(
        child: Column(
          spacing: 5.h,
          children: [
            Icon(isRefresh ? Icons.info_outline : FontAwesome.folder_closed, color: isRefresh ? Colors.red : Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 6.w,
              children: [
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp, color: isRefresh ? Colors.red : Colors.grey),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isRefresh,
              child: ElevatedButton.icon(
                onPressed: onPressed,
                label: Text("Refresh"),
                icon: Icon(Icons.refresh),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogHelper {
  static Future<void> showSelectedDialog<T>(
    BuildContext context, {
    required String title,
    required List<T> listData,
    required Widget Function(BuildContext context, T item, int index) itemBuilder,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 0.5.sh),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                spacing: 12.h,
                children: List.generate(listData.length, (index) => itemBuilder(context, listData[index], index)),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showSelectedYear<T>(BuildContext context, {required void Function(DateTime) onChanged}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Year"),
          content: SizedBox(
            width: 1.sw,
            height: 0.3.sh,
            child: YearPicker(
              firstDate: DateTime(1900).toLocal(),
              lastDate: DateTime(DateTime.now().year).toLocal(),
              selectedDate: DateTime.now(),
              onChanged: onChanged,
            ),
          ),
        );
      },
    );
  }

  static Future<void> showInfoDialog(
    BuildContext context, {
    Icon? icon,
    required String title,
    required String message,
    String confirmText = "OK",
    required void Function()? onPressed,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              ?icon,
              SizedBox(height: 4.h),
              Text(title, style: TextStyle(fontSize: 18.sp)),
            ],
          ),
          content: Text(message),
          actions: [TextButton(onPressed: onPressed, child: Text(confirmText))],
        );
      },
    );
  }

  static Future<void> showLoadingDialog<T>(BuildContext context, {String? message}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: CircularProgressIndicator()),
              const SizedBox(),
              Text(message ?? ""),
            ],
          ),
        );
      },
    );
  }
}

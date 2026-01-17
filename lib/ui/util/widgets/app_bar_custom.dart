import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

AppBar appBarCustom(
  BuildContext context, {
  required String title,
  required bool leadingBack,
  List<Widget>? action,
}) {
  return AppBar(
    title: Text(
      title,
      overflow: TextOverflow.ellipsis,
    ),
    leading: leadingBack
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          )
        : const SizedBox.shrink(),
    actions: action,
  );
}

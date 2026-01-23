import 'dart:io';

import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/ui/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/preferences_provider.dart';

class ItemDataUser extends StatelessWidget {
  ItemDataUser({super.key, required this.title, required this.value, this.filePhoto = '', this.hasPhoto = false});

  final String title, value, filePhoto;
  // final File? filePhoto;
  final bool hasPhoto;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provPref, _) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title.toUpperCase(),
                style: TextStyle(fontSize: 10.sp, color: provPref.isDarkTheme ? Colors.grey.shade300 : Colors.grey.shade600),
              ),
              SizedBox(width: 8.h),
              Row(
                spacing: 8.w,
                children: [
                  Expanded(
                    child: Text(
                      value,
                      softWrap: true,
                      style: TextStyle(fontSize: 11.sp, color: provPref.isDarkTheme ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Visibility(
                    visible: hasPhoto ? true : false,
                    child: InkWell(
                      onTap: () {
                        if (filePhoto.isEmpty) {
                          showFailSnackbar(context, "${title.toUpperCase()} doesn't have photo");
                          return;
                        }
                        Navigator.pushNamed(context, Routes.viewImageNetworkScreen, arguments: filePhoto);
                      },
                      child: Icon(filePhoto.isEmpty ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }
}

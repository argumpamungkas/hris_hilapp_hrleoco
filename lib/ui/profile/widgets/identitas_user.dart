import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../constant/routes.dart';
import '../../../providers/preferences_provider.dart';
import '../../util/widgets/image_network_custom.dart';

class IdentityUser extends StatelessWidget {
  const IdentityUser({super.key, required this.imageUrl, required this.name, required this.position});

  final String imageUrl, name, position;
  // final String imageUrl, name, position, service;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 80.h,
                width: 80.w,
                child: InkWell(
                  onTap: imageUrl.contains('default.png')
                      ? null
                      : () {
                          Navigator.pushNamed(context, Routes.viewImageNetworkScreen, arguments: imageUrl);
                        },
                  child: ClipOval(child: ImageNetworkCustom(url: imageUrl, isFit: true)),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                name,
                style: TextStyle(fontSize: 16.sp, color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700, fontWeight: FontWeight.bold),
              ),
              Text(
                position,
                style: TextStyle(color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700, fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
              SizedBox(height: 4.h),
            ],
          ),
        );
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/auth/widgets/form_sign_in.dart';
import 'package:easy_hris/ui/util/widgets/image_network_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/exports.dart';
import '../../providers/auth/sign_in_provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInProvider(),
      child: Scaffold(
        body: Consumer<PreferencesProvider>(
          builder: (context, prov, _) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ImageNetworkCustom(url: "${Constant.baseUrl}/${Constant.urlILogo}/${prov.configModel!.result.logo}"),
                      SizedBox(height: 24.h),
                      Text(
                        "WELCOME IN",
                        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        prov.configModel!.result.name!.toUpperCase(),
                        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Please enter your username and password",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      SizedBox(height: 16.h),
                      const FormSignIn(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

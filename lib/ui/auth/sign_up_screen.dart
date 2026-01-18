import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/auth/widgets/form_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../providers/auth/sign_up_provider.dart';
import '../util/widgets/image_network_custom.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.nameCompany});

  final String nameCompany;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: Consumer<PreferencesProvider>(
                        builder: (context, prov, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ImageNetworkCustom(url: "${prov.baseUrl}/${Constant.urlILogo}/${prov.configModel!.logo}"),
                              Text(
                                "REGISTER ACCOUNT",
                                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                prov.configModel!.name!.toUpperCase(),
                                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Please enter correctly your data",
                                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                              ),
                              SizedBox(height: 18.h),
                              const FormSignUp(),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, color: colorBlueDark),
                  color: colorBlueDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

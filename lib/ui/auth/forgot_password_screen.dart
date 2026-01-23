import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../providers/auth/forgot_password_provider.dart';
import '../util/utils.dart';
import '../util/widgets/image_network_custom.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordProvider(),
      child: Scaffold(
        body: Consumer<ForgotPasswordProvider>(
          builder: (context, provForgot, _) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Stack(
                  children: [
                    Consumer<PreferencesProvider>(
                      builder: (context, prov, _) {
                        return Container(
                          margin: const EdgeInsets.all(16),
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ImageNetworkCustom(url: "${prov.baseUrl}/${Constant.urlILogo}/${prov.configModel!.logo}"),
                              SizedBox(height: 18.h),
                              Text(
                                "Forgot Password",
                                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.h),
                              Text("Enter your Email We will send you New Password to registered Email", style: TextStyle(fontSize: 12.sp)),
                              SizedBox(height: 18.h),
                              Form(
                                key: provForgot.formKey,
                                child: TextFormField(
                                  controller: provForgot.emailC,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(hintText: "Email"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please input your Email";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20.h),
                              ElevatedButton(
                                onPressed: () async {
                                  if (provForgot.formKey.currentState!.validate()) {
                                    showLoadingDialog(context);
                                    final result = await provForgot.resetPassword();

                                    if (!context.mounted) return;
                                    Navigator.pop(context);
                                    if (result) {
                                      showInfoDialog(
                                        context,
                                        titleSuccess: provForgot.title,
                                        descriptionSuccess: provForgot.message,
                                        onPressed: () {
                                          Navigator.pushNamedAndRemoveUntil(context, Routes.signInScreen, (route) => false);
                                        },
                                      );
                                    } else {
                                      showInfoDialog(
                                        context,
                                        titleSuccess: provForgot.title,
                                        descriptionSuccess: provForgot.message,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorBlueDark,
                                  foregroundColor: Colors.white,
                                  textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  minimumSize: const Size.fromHeight(46),
                                ),
                                child: const Text("SEND MAIL"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new, color: colorBlueDark),
                      color: colorBlueDark,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

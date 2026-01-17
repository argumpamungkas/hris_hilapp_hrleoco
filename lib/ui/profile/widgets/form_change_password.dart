import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/providers/auth/profile_provider.dart';
import 'package:easy_hris/ui/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth/profile_change_password_provider.dart';
import '../../util/widgets/dialog_helpers.dart';
import '../../util/widgets/elevated_button_custom.dart';

class FormChangePassword extends StatelessWidget {
  const FormChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileChangePasswordProvider>(
      builder: (context, prov, _) {
        return Form(
          key: prov.formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            children: [
              SizedBox(height: 4.h),
              TextFormField(
                controller: prov.pwdController,
                obscureText: prov.pwdVisible,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      prov.visiblePassword();
                    },
                    icon: prov.pwdVisible == true ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                  ),
                ),
                validator: (value) {
                  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                  if (value!.isEmpty) {
                    return "Please input your Password";
                  } else if (!regex.hasMatch(value)) {
                    return "Minimum 8 Character with capital, lower, number & special character.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: prov.repeatPwdController,
                obscureText: prov.repeatPwdVisible,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Repeat Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      prov.visibleRepPassword();
                    },
                    icon: prov.repeatPwdVisible == true ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input Repeat Password";
                  } else if (value != prov.pwdController.text) {
                    return "Password are not the same";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              Consumer<ProfileProvider>(
                builder: (context, provProfile, _) {
                  return ElevatedButtonCustom(
                    onPressed: () {
                      if (prov.formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Change Password"),
                            content: const Text("Are you sure for Change Password?"),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                              TextButton(
                                onPressed: () async {
                                  if (prov.formKey.currentState!.validate()) {
                                    showLoadingDialog(context);

                                    final result = await prov.changePassword(provProfile.userModel!.username!);

                                    if (!context.mounted) return;
                                    Navigator.pop(context);
                                    if (result) {
                                      DialogHelper.showInfoDialog(
                                        context,
                                        icon: Icon(Icons.check, size: 32, color: Colors.green),
                                        title: prov.title,
                                        message: prov.message,
                                        onPressed: () {
                                          provProfile.onClearPrefs();
                                          Navigator.pushNamedAndRemoveUntil(context, Routes.signInScreen, (route) => false);
                                        },
                                      );
                                    } else {
                                      DialogHelper.showInfoDialog(
                                        context,
                                        icon: Icon(Icons.close_rounded, size: 32, color: Colors.red.shade700),
                                        title: prov.title,
                                        message: prov.message,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    }
                                  }
                                  // prov.changePassword(context);
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    title: 'Change Password',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

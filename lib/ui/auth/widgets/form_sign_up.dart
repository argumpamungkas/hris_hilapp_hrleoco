import 'package:easy_hris/ui/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../constant/routes.dart';
import '../../../providers/auth/sign_up_provider.dart';

class FormSignUp extends StatelessWidget {
  const FormSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, provSignUp, _) {
        return Form(
          key: provSignUp.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: provSignUp.employeeIdController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: "Employee ID"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input your Employee ID";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: provSignUp.usernameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: "New Username"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input your Username";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: provSignUp.pwdController,
                obscureText: provSignUp.pwdVisible,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).nextFocus();
                },
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      provSignUp.visiblePassword();
                    },
                    icon: provSignUp.pwdVisible == true ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
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
              const SizedBox(height: 16),
              TextFormField(
                controller: provSignUp.repeatPwdController,
                obscureText: provSignUp.repeatPwdVisible,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Repeat Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      provSignUp.visibleRepPassword();
                    },
                    icon: provSignUp.repeatPwdVisible == true ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input Repeat Password";
                  } else if (value != provSignUp.pwdController.text) {
                    return "Password are not the same";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (provSignUp.formKey.currentState!.validate()) {
                    showLoadingDialog(context);
                    final result = await provSignUp.createAccount();

                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (result) {
                      showInfoDialog(
                        context,
                        titleSuccess: provSignUp.title,
                        descriptionSuccess: provSignUp.message,
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, Routes.signInScreen, (route) => false);
                        },
                      );
                    } else {
                      showInfoDialog(
                        context,
                        titleSuccess: provSignUp.title,
                        descriptionSuccess: provSignUp.message,
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
                child: const Text("REGISTER"),
              ),

              Divider(height: 24.h),

              OutlinedButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  minimumSize: const Size.fromHeight(46),
                ),
                child: const Text("LOGIN"),
              ),
            ],
          ),
        );
      },
    );
  }
}

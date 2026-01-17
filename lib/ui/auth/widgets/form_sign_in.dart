import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../constant/routes.dart';
import '../../../providers/auth/sign_in_provider.dart';
import '../../util/utils.dart';

class FormSignIn extends StatelessWidget {
  const FormSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInProvider>(
      builder: (context, provSignIn, _) {
        return Form(
          key: provSignIn.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: provSignIn.usernameC,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: "Username"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input your username";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: provSignIn.pwdC,
                obscureText: provSignIn.pwdVisible,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      provSignIn.onChangePwd();
                    },
                    icon: Icon(provSignIn.pwdVisible ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input your Password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () async {
                  if (provSignIn.formKey.currentState!.validate()) {
                    showLoadingDialog(context);
                    if (!context.mounted) return;
                    await provSignIn.signInEmployee().then((value) {
                      if (!context.mounted) return;
                      Navigator.pop(context);
                      if (!value) {
                        showInfoDialog(
                          context,
                          titleSuccess: provSignIn.title,
                          descriptionSuccess: provSignIn.message,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      } else {
                        Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardScreen, (route) => false);
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorBlueDark,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  minimumSize: const Size.fromHeight(46),
                ),
                child: const Text("LOGIN"),
              ),

              Divider(height: 24.h),

              OutlinedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, Routes.signUpScreen, arguments: "PT KINENTA INDONESIA");
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  minimumSize: const Size.fromHeight(46),
                ),
                child: const Text("REGISTER"),
              ),

              SizedBox(height: 12.h),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.forgotPasswordScreen);
                },
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

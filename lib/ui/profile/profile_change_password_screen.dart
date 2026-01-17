import 'package:easy_hris/ui/profile/widgets/form_change_password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth/profile_change_password_provider.dart';
import '../util/widgets/app_bar_custom.dart';

class ProfileChangePasswordScreen extends StatelessWidget {
  const ProfileChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileChangePasswordProvider(),
      child: Scaffold(
        appBar: appBarCustom(context, title: "Change Password", leadingBack: true),
        body: const FormChangePassword(),
      ),
    );
  }
}

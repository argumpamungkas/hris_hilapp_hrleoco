import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom.appbar(context, title: "Privacy Policy", leadingBack: true),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          children: [
            Text(ConstantMessage.loremIpsumText),

            _item(title: "Information Collection and Use", description: ConstantMessage.loremIpsumText),
            _item(title: "Log Data", description: ConstantMessage.loremIpsumText),
            _item(title: "Cookies", description: ConstantMessage.loremIpsumText),
            _item(title: "Security", description: ConstantMessage.loremIpsumText),
          ],
        ),
      ),
    );
  }

  Widget _item({required String title, required String description}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 2.h,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          Text(description, style: TextStyle(fontSize: 13.sp)),
        ],
      ),
    );
  }
}

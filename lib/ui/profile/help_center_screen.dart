import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/profiles/help_center_provider.dart';
import 'package:easy_hris/ui/profile/content/contact_us_screen.dart';
import 'package:easy_hris/ui/profile/content/faq_screen.dart';
import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HelpCenterProvider(),
      child: Scaffold(
        appBar: AppbarCustom.appbar(context, title: "Help Center", leadingBack: true),
        body: SafeArea(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Container(
              padding: EdgeInsets.all(12.w),
              child: Column(
                spacing: 8.h,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer<HelpCenterProvider>(
                    builder: (context, prov, _) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 12.w,
                        children: [
                          _tabBarCustom(
                            title: "FAQ",
                            isActive: prov.index == 0,
                            onTap: () {
                              prov.onChangeTab(0);
                            },
                          ),
                          _tabBarCustom(
                            title: "Contact Us",
                            isActive: prov.index == 1,
                            onTap: () {
                              prov.onChangeTab(1);
                            },
                          ),
                        ],
                      );
                    },
                  ),

                  Consumer<HelpCenterProvider>(
                    builder: (context, prov, _) {
                      return prov.index == 0 ? FaqScreen() : ContactUsScreen();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabBarCustom({required String title, required bool isActive, required void Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: isActive ? ConstantColor.colorBlue : Colors.grey),
            ),
            Divider(color: isActive ? ConstantColor.colorBlue : Colors.grey, thickness: 4),
          ],
        ),
      ),
    );
  }

  Widget screenTab(int index) {
    return index == 0 ? FaqScreen() : ContactUsScreen();
  }
}

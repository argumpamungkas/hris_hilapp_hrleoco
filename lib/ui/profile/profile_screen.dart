import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/profile/widgets/identitas_user.dart';
import 'package:easy_hris/ui/profile/widgets/item_list_tile.dart';
import 'package:easy_hris/ui/util/utils.dart';
import 'package:easy_hris/ui/util/widgets/background_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/constant.dart';
import '../../constant/routes.dart';
import '../../providers/auth/profile_provider.dart';
import '../../providers/dashboard_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundHome(),
          Container(
            height: 1.sh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
            ),
            margin: EdgeInsets.only(top: 0.15.sh),
          ),

          Consumer3<ProfileProvider, PreferencesProvider, DashboardProvider>(
            builder: (context, prov, provPref, provDashboard, _) {
              return Container(
                margin: EdgeInsets.only(top: 0.1.sh),
                child: Column(
                  children: [
                    IdentityUser(
                      imageUrl: prov.photoProfile.isEmpty ? "${provPref.baseUrl}/${Constant.urlDefaultImage}" : prov.photoProfile,
                      name: prov.userModel?.name?.toUpperCase() ?? "",
                      position: prov.userModel?.position?.toUpperCase() ?? "",
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ItemListTile(
                              iconLeading: Icons.credit_card_outlined,
                              title: "ID Card",
                              onTap: () => Navigator.pushNamed(context, Routes.idCardScreen),
                            ),
                            ItemListTile(
                              iconLeading: Icons.notifications,
                              title: "Notification",
                              // onTap: () => Navigator.pushNamed(context, Routes.profileChangePasswordScreen),
                              onTap: () {},
                            ),
                            ItemListTile(
                              iconLeading: Icons.lock,
                              title: "Security",
                              onTap: () => Navigator.pushNamed(context, Routes.profileChangePasswordScreen),
                            ),
                            ItemListTile(
                              iconLeading: Icons.settings,
                              title: "Language",
                              // onTap: () => Navigator.pushNamed(context, Routes.profileChangePasswordScreen),
                              onTap: () {},
                            ),
                            ItemListTile(
                              iconLeading: Icons.privacy_tip,
                              title: "Privacy Policy",
                              // onTap: () => Navigator.pushNamed(context, Routes.profileChangePasswordScreen),
                              onTap: () {},
                            ),
                            ItemListTile(
                              iconLeading: Icons.send,
                              title: "Help Center",
                              // onTap: () => Navigator.pushNamed(context, Routes.profileChangePasswordScreen),
                              onTap: () {},
                            ),

                            SizedBox(height: 24.h),
                            ItemListTile(
                              iconLeading: Icons.logout_outlined,
                              title: "Logout",
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Logout"),
                                    content: const Text("Do you want to Logout?"),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                                      TextButton(
                                        onPressed: () async {
                                          showLoadingDialog(context);
                                          provDashboard.setIndex();
                                          final result = await prov.logoutUser();

                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                          if (result) {
                                            Navigator.pushNamedAndRemoveUntil(context, Routes.signInScreen, (route) => false);
                                          } else {
                                            showInfoDialog(
                                              context,
                                              titleSuccess: prov.title,
                                              descriptionSuccess: prov.message,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            );
                                          }
                                        },
                                        child: const Text("Yes"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          Consumer<PreferencesProvider>(
            builder: (context, prov, _) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        prov.enableDarkTheme();
                      },
                      icon: Icon(prov.isDarkTheme ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined, color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Shimmer _loadingProfile(double width) {
    return Shimmer.fromColors(
      baseColor: Colors.blueGrey.shade100,
      highlightColor: Colors.grey.shade50,
      child: Column(
        children: [
          Container(
            height: 100.h,
            width: 100.w,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          ),
          SizedBox(height: 16.h),
          Container(color: Colors.white, height: 20.h, width: 80.w),
          SizedBox(height: 8.h),
          Container(color: Colors.white, height: 20.h, width: 60.w),
          SizedBox(height: 8.h),
          Container(color: Colors.white, height: 20.h, width: 80.w),
          SizedBox(height: 16.h),
          Container(color: Colors.white, height: 50.h, width: width),
          SizedBox(height: 16.h),
          Container(color: Colors.white, height: 50.h, width: width),
          SizedBox(height: 16.h),
          Container(color: Colors.white, height: 50.h, width: width),
          SizedBox(height: 16.h),
          Container(color: Colors.white, height: 50.h, width: width),
        ],
      ),
    );
  }
}

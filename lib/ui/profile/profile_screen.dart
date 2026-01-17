import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/profile/widgets/identitas_user.dart';
import 'package:easy_hris/ui/profile/widgets/item_list_tile.dart';
import 'package:easy_hris/ui/util/utils.dart';
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
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                child: Center(
                  child: Consumer2<ProfileProvider, DashboardProvider>(
                    builder: (context, prov, provDashboard, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IdentityUser(
                            imageUrl: prov.userModel?.avatar == "" ? "${Constant.baseUrl}/${Constant.urlDefaultImage}" : "",
                            name: prov.userModel?.name?.toUpperCase() ?? "",
                            position: prov.userModel?.position?.toUpperCase() ?? "",
                          ),
                          SizedBox(height: 8.h),
                          const Divider(),
                          SizedBox(height: 8.h),
                          ItemListTile(
                            iconLeading: Icons.person,
                            title: "Personal Data",
                            onTap: () => Navigator.pushNamed(context, Routes.profilePersonalDataScreen),
                          ),
                          ItemListTile(
                            iconLeading: Icons.lock_outline_rounded,
                            title: "Change Password",
                            onTap: () => Navigator.pushNamed(context, Routes.profileChangePasswordScreen),
                          ),
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
                                      onPressed: () {
                                        showLoadingDialog(context);
                                        provDashboard.setIndex();
                                        prov.logout(context);
                                        Navigator.pushNamedAndRemoveUntil(context, Routes.signInScreen, (route) => false);
                                      },
                                      child: const Text("Yes"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),

            Consumer<PreferencesProvider>(
              builder: (context, prov, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        prov.enableDarkTheme();
                      },
                      icon: Icon(prov.isDarkTheme ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
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

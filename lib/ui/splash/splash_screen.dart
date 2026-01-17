import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_hris/providers/auth/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/constant.dart';
import '../../constant/exports.dart';
import '../../constant/routes.dart';
import '../../providers/preferences_provider.dart';
import '../../providers/splash_provider.dart';
import '../util/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Color colorBg = Colors.white;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      PreferencesProvider prov = Provider.of<PreferencesProvider>(context, listen: false);
      Provider.of<ProfileProvider>(context, listen: false).getUser();
      // await Provider.of<PreferencesProvider>(context, listen: false).fetchInit();
      colorBg = prov.isDarkTheme ? Colors.black : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashProvider(),
      child: Scaffold(
        body: Consumer2<SplashProvider, PreferencesProvider>(
          builder: (context, splashProv, prefProv, _) {
            return AnimatedSplashScreen.withScreenRouteFunction(
              backgroundColor: prefProv.isDarkTheme ? Colors.black : Colors.white,
              splash: Image.asset(Constant.logo, color: prefProv.isDarkTheme ? Colors.white : null),
              splashIconSize: 0.2.sw,
              splashTransition: SplashTransition.scaleTransition,
              screenRouteFunction: () async {
                final route = await splashProv.autoLogin();
                switch (route) {
                  case 'dashboard':
                    return Routes.dashboardScreen;
                  case 'signIn':
                    return Routes.signInScreen;
                  default:
                    {
                      showFailedDialog(context, titleFailed: "Permission", descriptionFailed: splashProv.message);
                      Future.delayed(const Duration(seconds: 2));
                      Navigator.pop(context);
                      Future.delayed(const Duration(seconds: 1));
                      return Routes.splashScreen;
                    }
                }
              },
            );
          },
        ),
      ),
    );
  }
}

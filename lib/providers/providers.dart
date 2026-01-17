import 'package:easy_hris/providers/preferences_provider.dart';

import '../constant/exports.dart';
import '../data/helpers/preferences_helper.dart';
import 'auth/profile_provider.dart';
import 'notifications/notification_provider.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (context) => PreferencesProvider(preferencesHelper: PreferencesHelper(sharedPref: SharedPreferences.getInstance())),
    ),
    // ChangeNotifierProvider(create: (context) => HomeProvider()),
    ChangeNotifierProvider(create: (context) => ProfileProvider()),
    ChangeNotifierProvider(create: (context) => NotificationProvider()), // Sementara
    // ChangeNotifierProvider(create: (context) => AttendanceTeamController()),
    // ChangeNotifierProvider(create: (context) => AttendanceController()),
    // ChangeNotifierProvider(create: (context) => AttendanceLocationController()),
    // ChangeNotifierProvider(create: (context) => ChangeDaysProvider()),
    // ChangeNotifierProvider(create: (context) => OvertimeProvider()), // NEW OVT
    // ChangeNotifierProvider(create: (context) => PermitProvider()), // NEW PERMIT
    // ChangeNotifierProvider(create: (context) => PayslipProvider()),
  ];
}

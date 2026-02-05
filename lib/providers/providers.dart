import 'package:easy_hris/providers/preferences_provider.dart';

import '../constant/exports.dart';
import '../data/helpers/preferences_helper.dart';
import 'auth/profile_provider.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (context) => PreferencesProvider(preferencesHelper: PreferencesHelper(sharedPref: SharedPreferences.getInstance())),
    ),
    ChangeNotifierProvider(create: (context) => ProfileProvider()),
  ];
}

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPref;

  PreferencesHelper({required this.sharedPref});

  static const darkTheme = "DARK_THEME";
  static const notif = "NOTIFICATION";
  static const fcmToken = "FCMTOKEN";

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPref;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPref;
    prefs.setBool(darkTheme, value);
  }

  Future<bool> get notificationActive async {
    final prefs = await sharedPref;
    return prefs.getBool(notif) ?? false;
  }

  void setNotification(bool value) async {
    final prefs = await sharedPref;
    prefs.setBool(notif, value);
  }

  Future<String?> get getFcmToken async {
    final prefs = await sharedPref;
    return prefs.getString(fcmToken);
  }

  void setFcmToken(String value) async {
    final prefs = await sharedPref;
    prefs.setString(notif, value);
  }
}

import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/constant.dart';

class ApiHome {
  Future<dynamic> fetchHomeApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString("apiKey") != null && prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
      apiKey = prefs.getString("apiKey")!;
    }

    Uri urlAttendanceToday = Uri.parse("${link}api/dashboard/attendance/$apiKey");
    Uri urlAttendanceSummary = Uri.parse("${link}api/dashboard/attandanceSummary/$apiKey");
    // print("URL ATTENDANCES SUMMARY $urlAttendanceSummary");
    Uri urlNews = Uri.parse("${link}api/news/reads/$apiKey");

    final response = await Future.wait([
      http.get(urlAttendanceToday),
      http.get(urlAttendanceSummary),
      http.get(urlNews),
    ]).timeout(const Duration(seconds: 30));

    try {
      return response;
    } catch (e) {
      // print(e);
      throw errMessage;
    }
  }
}

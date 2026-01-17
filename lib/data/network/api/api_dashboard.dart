import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/constant.dart';

class ApiDashboard {
  Future<Map<String, dynamic>> fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/dashboard/users/$apiKey");

    try {
      var response = await http.get(url);
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseBody["theme"] == "success") {
          return responseBody;
        } else {
          return responseBody;
        }
      } else {
        return responseBody;
      }
    } catch (e) {
      // print(e);
      throw errMessage;
    }
  }

  Future<Map<String, dynamic>> fetchAttendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/dashboard/attendance/$apiKey");

    try {
      var response = await http.get(url);
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseBody["theme"] == "success") {
          return responseBody;
        } else {
          return responseBody;
        }
      } else {
        return responseBody;
      }
    } catch (e) {
      throw errMessage;
    }
  }

  Future<Map<String, dynamic>> fetchAttendanceSummary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/dashboard/attandanceSummary/$apiKey");

    try {
      var response = await http.get(url);
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      throw errMessage;
    }
  }

  Future<Map<String, dynamic>> fetchDaysOff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/dashboard/dayOff/$apiKey");

    try {
      var response = await http.get(url);
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseBody["theme"] == "success") {
          return responseBody;
        } else if (response.statusCode == 500) {
          throw Exception("Server Error");
        } else {
          return responseBody;
        }
      } else {
        return responseBody;
      }
    } catch (e) {
      throw errMessage;
    }
  }

  Future<Map<String, dynamic>> fetchNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/news/reads/$apiKey");

    try {
      var response = await http.get(url).timeout(const Duration(seconds: 30));
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseBody["theme"] == "success") {
          return responseBody;
        } else {
          return responseBody;
        }
      } else {
        return responseBody;
      }
    } catch (e) {
      throw errMessage;
    }
  }

  Future<Map<String, dynamic>> fetchTeams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/teams/reads/$apiKey");

    try {
      var response = await http.get(url).timeout(const Duration(seconds: 30));
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseBody["theme"] == "success") {
          return responseBody;
        } else {
          return responseBody;
        }
      } else {
        return responseBody;
      }
    } catch (e) {
      throw errMessage;
    }
  }

  Future<Map<String, dynamic>> fetchTeamAttendancePerson({required String requestDate, required String employee_id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/teams/attendanceSummaryTeamPerson/$apiKey");

    try {
      var response = await http.post(url, body: {"request_date": requestDate, "employee_id": employee_id}).timeout(const Duration(seconds: 30));
      var responseBody = jsonDecode(response.body);

      // print("RESPONSE $responseBody");

      if (response.statusCode == 200) {
        if (responseBody["theme"] == "success") {
          return responseBody;
        } else {
          return responseBody;
        }
      } else {
        return responseBody;
      }
    } catch (e) {
      throw errMessage;
    }
  }

  Future<Map<String, dynamic>> fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/profiles/reads/$apiKey");

    // print('URL => $url');

    try {
      var response = await http.get(url);
      // debugPrint("RESP BODY => ${response.body}");
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseBody["theme"] == "success") {
          return responseBody;
        } else {
          return responseBody;
        }
      } else {
        return responseBody;
      }
    } on SocketException {
      throw errMessageNoInternet;
    } catch (e) {
      // print("e $e");
      throw errMessage;
    }
  }

  Future<Map<String, dynamic>> fetchCutOff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    if (prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
    }

    Uri url = Uri.parse("${link}api/dashboard/cutOff");

    try {
      var response = await http.get(url);
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseBody["theme"] == "success") {
          return responseBody;
        } else {
          return responseBody;
        }
      } else {
        return responseBody;
      }
    } catch (e) {
      throw errMessage;
    }
  }

  Future<List> fetchVersion() async {
    Uri url = Uri.parse("${Constant.baseUrlMaster}?get=version");

    try {
      var response = await http.get(url);
      var responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      // print(e.toString());
      throw errMessage;
    }
  }

  ///NEW ATTENDANCE SUMMARY
  Future<Map<String, dynamic>> fetchAttendanceSummaryByDate({required String requestDate}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/dashboard/attendanceSummaryByDate/$apiKey");

    try {
      var response = await http.post(url, body: {"request_date": requestDate}).timeout(const Duration(seconds: 30));
      var responseBody = jsonDecode(response.body);

      // print("RESPONSE $responseBody");

      if (response.statusCode == 200) {
        if (responseBody["theme"] == "success") {
          return responseBody;
        } else {
          return responseBody;
        }
      } else {
        return responseBody;
      }
    } catch (e) {
      throw errMessage;
    }
  }
}

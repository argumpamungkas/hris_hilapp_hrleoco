import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constant/constant.dart';

class ApiNotification {
  Future<Map<String, dynamic>> fetchNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString("apiKey") != null && prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
      apiKey = prefs.getString("apiKey")!;
    }

    Uri url = Uri.parse("${link}api/notifications/approvalList/$apiKey");

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

  Future<Map<String, dynamic>> fetchNotificationDetail(String approvedTo, String approvedBy, String module) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    if (prefs.getString("apiKey") != null && prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
    }

    Uri url = Uri.parse("${link}api/notifications/approvalDetails/$approvedTo/$approvedBy/$module");

    try {
      var response = await http.get(url);

      // print("Response detail ${response.body}");

      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var status = responseBody['theme'];
        if (status == "success") {
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

  Future<Map<String, dynamic>> approved(String id, String module) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString("apiKey") != null && prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
      apiKey = prefs.getString("apiKey")!;
    }

    Uri url = Uri.parse("${link}api/notifications/approve/$apiKey");

    try {
      var response = await http.post(url, body: {"id": id, "module": module});
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var status = responseBody['theme'];
        if (status == "success") {
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

  Future<Map<String, dynamic>> approvedAll(String module, String approvedTo, String createdBy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString("apiKey") != null && prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
      apiKey = prefs.getString("apiKey")!;
    }

    Uri url = Uri.parse("${link}api/notifications/approveAll/$apiKey");

    try {
      var response = await http.post(url, body: {"module": module, "approved_to": approvedTo, "created_by": createdBy});
      var responseBody = jsonDecode(response.body);

      // print("RESPINSE $response");
      // print("RESPINSE2 ${response.body}");

      if (response.statusCode == 200) {
        var status = responseBody['theme'];
        if (status == "success") {
          return responseBody;
        } else {
          return responseBody;
        }
      } else {
        return responseBody;
      }
    } catch (e) {
      // print("ERROR $e");
      throw errMessage;
    }
  }

  Future<Map<String, dynamic>> disapproved(String id, String module) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString("apiKey") != null && prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
      apiKey = prefs.getString("apiKey")!;
    }

    Uri url = Uri.parse("${link}api/notifications/disapprove/$apiKey");

    try {
      var response = await http.post(url, body: {"id": id, "module": module});
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var status = responseBody['theme'];
        if (status == "success") {
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

  Future<Map<String, dynamic>> disapprovedAll(String module, String approvedTo, String createdBy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString("apiKey") != null && prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
      apiKey = prefs.getString("apiKey")!;
    }

    Uri url = Uri.parse("${link}api/notifications/disapproveAll/$apiKey");

    try {
      var response = await http.post(url, body: {"module": module, "approved_to": approvedTo, "created_by": createdBy});
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var status = responseBody['theme'];
        if (status == "success") {
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

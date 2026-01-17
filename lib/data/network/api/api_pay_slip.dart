import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constant/constant.dart';

class ApiPaySlip {
  Future<Map<String, dynamic>> fetchPaySlip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString("apiKey") != null && prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
      apiKey = prefs.getString("apiKey")!;
    }

    Uri url = Uri.parse("${link}api/payslip/reads/$apiKey");

    try {
      var response = await http.get(url);
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // debugPrint("$responseBody");
        if (responseBody["theme"] == "success") {
          return responseBody;
        } else {
          return responseBody;
        }
      } else {
        throw "${response.statusCode}. $errMessage";
      }
    } catch (e) {
      throw errMessage;
    }
  }
}

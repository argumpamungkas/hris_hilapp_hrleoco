import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constant/constant.dart';

class ApiOvertime {
  Future<Map<String, dynamic>> fetchOvertime(int year) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    // Uri url = Uri.parse("${link}api/overtimes/reads/$apiKey");
    Uri url = Uri.parse("${link}api/overtimes/list/$apiKey/$year");
    // print("URL $url");

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

  Future<Map<String, dynamic>> fetchShift(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/overtimes/readShifts/$apiKey");

    try {
      var response = await http.post(url, body: {'trans_date': date});
      var responseBody = jsonDecode(response.body);
      // print("RESPONSE BODY $responseBody");
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

  Future<Map<String, dynamic>> addOvertime(
    String requestDate,
    String start,
    String end,
    String resBreak,
    String meal,
    String plan,
    String actual,
    File? attachment,
    String remarks,
  ) async {
    // print("CALL API 1");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("CALL API 2");
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    // print("CALL API 3");
    Uri url = Uri.parse("${link}api/overtimes/createData/$apiKey");
    var request = http.MultipartRequest("POST", url);
    request.fields['request_date'] = requestDate;
    request.fields['start'] = start;
    request.fields['end'] = end;
    request.fields['break'] = resBreak;
    request.fields['meal'] = meal;
    request.fields['plan'] = plan;
    request.fields['actual'] = actual;
    request.fields['remarks'] = remarks;

    if (attachment != null) {
      request.files.add(http.MultipartFile.fromBytes("attachment", attachment.readAsBytesSync(), filename: attachment.path));
    } else {
      request.fields['attachment'] = "";
    }

    // print("CALL API 4");
    // print("API KEY $apiKey");
    var stream = await request.send();
    var response = await http.Response.fromStream(stream);
    // print("RESPONSE ${response.body}");
    var respBody = jsonDecode(response.body);
    // print("CALL API 5");
    // print("RESP BODY $respBody");
    if (response.statusCode == 200) {
      return respBody;
    } else {
      return respBody;
    }
  }

  Future<Map<String, dynamic>> cancelRequestOvertime(String requestCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/overtimes/cancel/$apiKey");

    try {
      var response = await http.post(url, body: {"id": requestCode});
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

  /// untuk di overtimes
  Future<Map<String, dynamic>> overtimeSummary(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/overtimes/overtimeSummary/$apiKey");
    print("URL overtime summary $url");

    try {
      var response = await http.post(url, body: {'trans_date': date});
      var responseBody = jsonDecode(response.body);
      print("RESPONSE $responseBody");
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      print("ERROR $e");
      throw errMessage;
    }
  }
}

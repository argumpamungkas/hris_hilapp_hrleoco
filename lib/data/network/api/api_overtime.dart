import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_hris/data/models/response/overtime_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constant/constant.dart';
import '../../../injection.dart';
import '../../services/url_services.dart';

class ApiOvertime {
  final _urlService = sl<UrlServices>();

  Future<OvertimeModel> fetchOvertime(String number, int year) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/overtimes/reads?number=$number&year=$year");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      return OvertimeModel.fromJson(result);
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      throw Exception("${ConstantMessage.errMsg} $e");
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
    // print("URL overtime summary $url");

    try {
      var response = await http.post(url, body: {'trans_date': date});
      var responseBody = jsonDecode(response.body);
      // print("RESPONSE $responseBody");
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

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_hris/data/models/response/notification_model.dart';
import 'package:easy_hris/data/services/url_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constant/constant.dart';
import '../../../injection.dart';
import '../../models/response/api_response.dart';
import '../../models/response/permit_type_model.dart';

class ApiNotification {
  final _urlService = sl<UrlServices>();

  Future<ApiResponse<List<NotificationModel>>> fetchNotification(String number) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/notifications/reads?number=$number");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      // print("result => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => NotificationModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
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

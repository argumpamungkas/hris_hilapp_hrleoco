import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_hris/data/models/response/api_response.dart';
import 'package:easy_hris/data/models/response/config_model.dart';
import 'package:easy_hris/data/services/url_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/constant.dart';
import '../../../injection.dart';

class ApiAuth {
  final _urlService = sl<UrlServices>();

  Future<ApiResponse<ConfigModel>> fetchConfig() async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl?.link}/api/auth/config");

    print("URL =>> $url");

    try {
      var response = await http.get(url);

      print("response config ${response.body}");

      Map<String, dynamic> result = jsonDecode(response.body);

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => ConfigModel.fromJson(json));

      // if (response.statusCode == 200) {
      //   var status = result["theme"];
      //
      //   if (status == "success") {
      //     return result;
      //   } else {
      //     return result;
      //   }
      // } else {
      //   return result;
      // }
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      print("TRACE $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<dynamic> loginUser(String username, String pwd) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/auth/login");

    try {
      var response = await http.post(url, body: {"username": username, "password": pwd});
      // print(response.body);

      Map<String, dynamic> result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var status = result["theme"];

        if (status == "success") {
          return result;
        } else {
          return result;
        }
      } else {
        return result;
      }
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e) {
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<Map<String, dynamic>> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }
    Uri url = Uri.parse("${Constant.baseUrlMaster}/");

    try {
      var response = await http.post(url, body: {"get": "logout", "api_key": apiKey});

      Map<String, dynamic> result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var status = result["theme"];
        if (status == "success") {
          return result;
        } else {
          return result;
        }
      } else {
        return result;
      }
    } catch (e) {
      return {"title": "Failed logout"};
    }
  }

  Future<Map<String, dynamic>> registerUser(String employeeId, String username, String pwd) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/auth/register");

    try {
      var response = await http.post(url, body: {"number": employeeId, "username": username, "password": pwd});

      // print("response register ${response.body}");

      var respBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var status = respBody["theme"];

        if (status == "success") {
          return respBody;
        } else {
          return respBody;
        }
      } else {
        return respBody;
      }
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e) {
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/auth/forgotPassword");

    try {
      var response = await http.post(url, body: {"email": email});

      var respBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var status = respBody["theme"];

        if (status == "success") {
          return respBody;
        } else {
          return respBody;
        }
      } else {
        return respBody;
      }
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e) {
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse> changePassword(String username, String password) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/auth/changePassword");

    try {
      var response = await http.post(url, body: {"username": username, "password": password});

      Map<String, dynamic> result = jsonDecode(response.body);

      // debugPrint("result change => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => null);
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("debugPrint $e");
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }
}

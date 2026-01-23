import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/constant.dart';
import '../../../injection.dart';
import '../../models/response/api_response.dart';
import '../../services/url_services.dart';

class ApiAttendance {
  final _urlService = sl<UrlServices>();

  Future<ApiResponse> submitAttendances({
    required String number,
    required String transDate,
    required String transTime,
    required String location,
    required File filePhotoAttendance,
  }) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl?.link}/api/attandances/create");

    try {
      final request = http.MultipartRequest("POST", url);

      final req = {'number': number, 'trans_date': transDate, 'trans_time': transTime, 'location': location};

      request.fields.addAll(req);

      request.files.add(await http.MultipartFile.fromPath('foto', filePhotoAttendance.path));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      // decode JSON
      final Map<String, dynamic> result = jsonDecode(responseBody);

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => null);
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<Map<String, dynamic>> fetchLocationOffice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    if (prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
    }

    Uri url = Uri.parse("${link}api/attandances/location");

    try {
      var response = await http.post(url, body: {"link": link});
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

  Future<Map<String, dynamic>> checkLocationAttendance({required String latitude, required String longitude}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link, apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/attandances/checkLocationAttendance/$apiKey");

    try {
      var response = await http.post(url, body: {"link": link, 'latitude': latitude, 'longitude': longitude});
      var responseBody = jsonDecode(response.body);

      // print("response $responseBody");

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

  Future<Map<String, dynamic>> fetchHistoryAttendance(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    // Uri url = Uri.parse("${link}api/attandances/reads/$apiKey");
    Uri url = Uri.parse("${link}api/attandances/list/$apiKey");

    try {
      var response = await http.post(url, body: {'date': date});
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

  Future<Map<String, dynamic>> sendAttendanceIn(
    String dateIn,
    String timeIn,
    File pathPicture,
    String companyCode,
    // String location,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/attandances/createData/$apiKey");
    // print("URL => $url");
    var request = http.MultipartRequest("POST", url);
    request.fields['date_in'] = dateIn;
    request.fields['date_out'] = "";
    request.fields['time_in'] = timeIn;
    request.fields['time_out'] = "";
    request.fields['position'] = companyCode;
    // request.fields['location'] = location;
    request.files.add(http.MultipartFile.fromBytes("foto", pathPicture.readAsBytesSync(), filename: pathPicture.path));

    var stream = await request.send();
    var response = await http.Response.fromStream(stream);
    var respBody = jsonDecode(response.body);
    // print("RESP BODY $respBody and ${response.statusCode}");
    try {
      if (response.statusCode == 200) {
        return respBody;
      } else {
        return respBody;
      }
    } catch (e) {
      // print("MASUK ERROR");
      return {'theme': 'error'};
    }
  }

  Future<Map<String, dynamic>> sendAttendanceOut(
    String dateIn,
    String dateOut,
    String timeIn,
    String timeOut,
    File pathPicture,
    String companyCode,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null && prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url = Uri.parse("${link}api/attandances/createData/$apiKey");
    var request = http.MultipartRequest("POST", url);
    request.fields['date_in'] = dateIn;
    request.fields['date_out'] = dateOut;
    request.fields['time_in'] = timeIn;
    request.fields['time_out'] = timeOut;
    request.fields['position'] = companyCode;
    // request.fields['location'] = location;
    request.files.add(http.MultipartFile.fromBytes("foto", pathPicture.readAsBytesSync(), filename: pathPicture.path));

    var stream = await request.send();
    var response = await http.Response.fromStream(stream);
    var respBody = jsonDecode(response.body);
    // print("RESP BODY $respBody and ${response.statusCode}");
    try {
      if (response.statusCode == 200) {
        return respBody;
      } else {
        return respBody;
      }
    } catch (e) {
      // print("MASUK ERROR");
      return {'theme': 'error'};
    }
  }
}

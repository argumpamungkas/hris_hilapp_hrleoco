import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/constant.dart';

class ApiAttendance {
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

  Future<Map<String, dynamic>> checkLocationAttendance({
    required String latitude,
    required String longitude,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link, apiKey;
    if (prefs.getString(ConstantSharedPref.apiKey) != null &&
        prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    Uri url =
        Uri.parse("${link}api/attandances/checkLocationAttendance/$apiKey");

    try {
      var response = await http.post(url,
          body: {"link": link, 'latitude': latitude, 'longitude': longitude});
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
    if (prefs.getString(ConstantSharedPref.apiKey) != null &&
        prefs.getString(ConstantSharedPref.linkServer) != null) {
      link = prefs.getString(ConstantSharedPref.linkServer)!;
      apiKey = prefs.getString(ConstantSharedPref.apiKey)!;
    }

    // Uri url = Uri.parse("${link}api/attandances/reads/$apiKey");
    Uri url = Uri.parse("${link}api/attandances/list/$apiKey");

    try {
      var response = await http.post(url, body: {
        'date': date,
      });
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
    if (prefs.getString(ConstantSharedPref.apiKey) != null &&
        prefs.getString(ConstantSharedPref.linkServer) != null) {
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
    request.files.add(
      http.MultipartFile.fromBytes(
        "foto",
        pathPicture.readAsBytesSync(),
        filename: pathPicture.path,
      ),
    );

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
    if (prefs.getString(ConstantSharedPref.apiKey) != null &&
        prefs.getString(ConstantSharedPref.linkServer) != null) {
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
    request.files.add(
      http.MultipartFile.fromBytes(
        "foto",
        pathPicture.readAsBytesSync(),
        filename: pathPicture.path,
      ),
    );

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

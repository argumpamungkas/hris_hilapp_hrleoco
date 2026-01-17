import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/constant.dart';

class ApiPermit {
  Future<Map<String, dynamic>> fetchPermit(int year) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString("apiKey") != null && prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
      apiKey = prefs.getString("apiKey")!;
    }

    // Uri url = Uri.parse("${link}api/permits/reads/$apiKey");
    Uri url = Uri.parse("${link}api/permits/list/$apiKey/$year");

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

  Future<List<dynamic>> fetchPermitType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    if (prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
    }

    Uri url = Uri.parse("${link}api/permits/readTypes");

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

  Future<List<dynamic>> fetchPermitReason(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    if (prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
    }

    Uri url = Uri.parse("${link}api/permits/readReason/$id");

    try {
      var response = await http.get(url);
      var responseBody = jsonDecode(response.body);

      // print("RESPONSE BODY $responseBody");

      if (response.statusCode == 200) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      throw errMessage;
    }
  }

  Future<Map<String, dynamic>> fetchPermitAvailable({
    required String permitTypeId,
    required String reasonId,
    required String dateFrom,
    required String dateTo,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString("apiKey") != null && prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
      apiKey = prefs.getString("apiKey")!;
    }

    Uri url = Uri.parse("${link}api/permits/readPermitAvailable/$apiKey");

    // print("URL $url");

    try {
      var response = await http.post(url, body: {'permit_type_id': permitTypeId, 'reason_id': reasonId, 'date_from': dateFrom, 'date_to': dateTo});

      // print(permitTypeId);
      // print(reasonId);
      // print(dateFrom);
      // print(dateTo);
      // print("RESPONSE $response");
      // print("RESPONSE ${response.body}");

      var responseBody = jsonDecode(response.body);
      print("Fetch permit available $responseBody");
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        return responseBody;
      }
    } catch (e) {
      throw errMessage;
    }
  }

  // Future<Map<String, dynamic>> fetchPermitAvailable(String id) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   late String link;
  //   late String apiKey;
  //   if (prefs.getString("apiKey") != null &&
  //       prefs.getString("linkServer") != null) {
  //     link = prefs.getString("linkServer")!;
  //     apiKey = prefs.getString("apiKey")!;
  //   }
  //
  //   Uri url = Uri.parse("${link}api/permits/readLeave/$apiKey/$id");
  //
  //   try {
  //     var response = await http.get(url);
  //     var responseBody = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       return responseBody;
  //     } else {
  //       return responseBody;
  //     }
  //   } catch (e) {
  //     throw errMessage;
  //   }
  // }

  Future<Map<String, dynamic>> addPermit(
    String permitTypeId,
    String reasonId,
    String dateFrom,
    String dateTo,
    String leave,
    String remarks,
    File? attachment,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString("apiKey") != null && prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
      apiKey = prefs.getString("apiKey")!;
    }

    Uri url = Uri.parse("${link}api/permits/createData/$apiKey");
    var request = http.MultipartRequest("POST", url);
    request.fields['permit_type_id'] = permitTypeId;
    request.fields['reason_id'] = reasonId;
    request.fields['date_from'] = dateFrom;
    request.fields['date_to'] = dateTo;
    request.fields['leave'] = leave;
    request.fields['remarks'] = remarks;

    if (attachment != null) {
      request.files.add(http.MultipartFile.fromBytes("attachment", attachment.readAsBytesSync(), filename: attachment.path));
    } else {
      request.fields['attachment'] = "";
    }

    var stream = await request.send();
    try {
      var response = await http.Response.fromStream(stream);
      var respBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return respBody;
      } else {
        return respBody;
      }
    } catch (e) {
      // debugPrint("STATUS CODE add permit ${e.toString()}");
      print("error $e");
      throw errMessage;
    }
  }

  Future<Map<String, dynamic>> cancelRequestPermit(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    late String link;
    late String apiKey;
    if (prefs.getString("apiKey") != null && prefs.getString("linkServer") != null) {
      link = prefs.getString("linkServer")!;
      apiKey = prefs.getString("apiKey")!;
    }

    Uri url = Uri.parse("${link}api/permits/cancel/$apiKey");

    try {
      var response = await http.post(url, body: {"id": id});
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
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_hris/data/models/response/permit_model.dart';
import 'package:easy_hris/data/models/response/permit_type_model.dart';
import 'package:easy_hris/data/models/response/reason_model.dart';
import 'package:easy_hris/data/services/url_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/constant.dart';
import '../../../injection.dart';
import '../../models/response/api_response.dart';

class ApiPermit {
  final _urlService = sl<UrlServices>();

  Future<PermitModel> fetchPermit(String number, int year) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/permits/reads?number=$number&year=$year");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      return PermitModel.fromJson(result);
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<List<PermitTypeModel>>> fetchPermitTypes() async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/master/readPermitTypes");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      // print("result => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => PermitTypeModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<List<ReasonModel>>> fetchReason({required String permitTypeId}) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/master/readReasons?permit_type_id=$permitTypeId");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      print("result => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => ReasonModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      debugPrint("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse> addPermit({
    required String number,
    required String permitDate,
    required String permitTypeId,
    required String reasonId,
    required String start,
    required String end,
    required String note,
    required File? attachment,
  }) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/permits/create");

    try {
      var request = http.MultipartRequest("POST", url);
      request.fields['number'] = number;
      request.fields['permit_date'] = permitDate;
      request.fields['permit_type_id'] = permitTypeId;
      request.fields['reason_id'] = reasonId;
      request.fields['start_time'] = start;
      request.fields['end_time'] = end;
      request.fields['note'] = note;

      if (attachment != null) {
        request.files.add(await http.MultipartFile.fromPath('attachment', attachment.path));
      } else {
        request.fields['attachment'] = "";
      }

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
      // print("trace $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
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

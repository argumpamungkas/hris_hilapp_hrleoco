import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_hris/data/models/request/change_day_request.dart';
import 'package:easy_hris/data/models/response/change_day_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constant/constant.dart';
import '../../../injection.dart';
import '../../models/response/api_response.dart';
import '../../services/url_services.dart';

class ApiChangeDay {
  final _urlService = sl<UrlServices>();

  Future<ApiResponse<List<ChangeDayModel>>> fetchChangeDay(String number, int year) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/change_days/reads?number=$number&year=$year");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      // print("result => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => ChangeDayModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse> createChangeDay(ChangeDayRequest request) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/change_days/create");

    try {
      var response = await http.post(url, body: request.toJson());

      Map<String, dynamic> result = jsonDecode(response.body);

      // debugPrint("result add educ => $result");

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

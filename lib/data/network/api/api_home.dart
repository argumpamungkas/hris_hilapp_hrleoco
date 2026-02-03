import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_hris/data/models/response/announcement_model.dart';
import 'package:easy_hris/data/models/response/api_response.dart';
import 'package:easy_hris/data/models/response/attendance_summary_model.dart';
import 'package:easy_hris/data/models/response/permit_today_model.dart';
import 'package:easy_hris/data/models/response/shift_user_model.dart';
import 'package:easy_hris/data/models/response/team_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/constant.dart';
import '../../../injection.dart';
import '../../models/response/attendance_model.dart';
import '../../services/url_services.dart';

class ApiHome {
  final _urlService = sl<UrlServices>();

  Future<ApiResponse<List<AttendanceModel>>> fetchAttendanceData(String number, String transDateFrom, String transDateTo) async {
    final baseUrl = await _urlService.getUrlModel();

    /// yyyy-mm-dd
    Uri url = Uri.parse("${baseUrl?.link}/api/attandances/reads?number=$number&trans_from=$transDateFrom&trans_to=$transDateTo");

    // print("URL =>> $url");

    try {
      var response = await http.get(url);

      // print("response config ${response.body}");

      Map<String, dynamic> result = jsonDecode(response.body);

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => AttendanceModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("TRACE $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<ShiftUserModel>> fetchShiftUser(String number) async {
    final baseUrl = await _urlService.getUrlModel();

    /// yyyy-mm-dd
    Uri url = Uri.parse("${baseUrl?.link}/api/attandances/readShift?number=$number");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => ShiftUserModel.fromJson(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("TRACE $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<AttendanceSummaryModel>> fetchAttendanceSummary(String number, int month, int year) async {
    final baseUrl = await _urlService.getUrlModel();

    /// yyyy-mm-dd
    Uri url = Uri.parse("${baseUrl?.link}/api/attandances/readSummaries?number=$number&month=$month&year=$year");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => AttendanceSummaryModel.fromJson(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("TRACE $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<List<PermitTodayModel>>> fetchPermitToday() async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl?.link}/api/permits/readToday");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => PermitTodayModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("TRACE $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<List<AnnouncementModel>>> fetchAnnouncement(String number) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl?.link}/api/announcements/reads?number=$number");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => AnnouncementModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("TRACE $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<List<TeamModel>>> fetchTeam(String number) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl?.link}/api/teams/reads?number=$number");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => TeamModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("TRACE $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }
}

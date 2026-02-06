import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/response/attendance_model.dart';
import 'package:easy_hris/data/network/api/api_home.dart';
import 'package:easy_hris/data/services/url_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../injection.dart';

class AttendanceHistoryProvider extends ChangeNotifier {
  final ApiHome _api = ApiHome();
  final _prefs = sl<SharedPreferences>();
  final _urlService = sl<UrlServices>();

  List<AttendanceModel> _listAttendance = [];
  ResultStatus _resultStatus = ResultStatus.init;
  String _message = '';
  String _baseUrl = '';
  DateTime _date = DateTime.now().toLocal();

  List<AttendanceModel> get listAttendance => _listAttendance;
  ResultStatus get resultStatus => _resultStatus;
  String get message => _message;
  String get baseUrl => _baseUrl;
  DateTime get date => _date;

  AttendanceHistoryProvider() {
    init();
  }

  Future<void> getUrl() async {
    final urlModel = await _urlService.getUrlModel();
    _baseUrl = urlModel!.link!;
    return;
  }

  Future<void> init() async {
    getUrl();
    try {
      await fetchAttendanceHistory(month: _date.month, year: _date.year);
    } catch (e) {
      _message = e.toString();
      _resultStatus = ResultStatus.error;
      notifyListeners();
    }
  }

  Future<void> fetchAttendanceHistory({required int month, required int year}) async {
    _listAttendance.clear();
    _resultStatus = ResultStatus.loading;
    notifyListeners();

    final number = _prefs.getString(ConstantSharedPref.numberUser);

    try {
      final result = await _api.fetchAttendanceData(number ?? "", month.toString(), year.toString());
      final listData = result.result;

      if (result.theme == 'success') {
        if (listData!.isEmpty) {
          _resultStatus = ResultStatus.noData;
          _message = "History Attendance is Empty";
          notifyListeners();
        } else {
          _listAttendance.addAll(listData);
          _resultStatus = ResultStatus.hasData;
          notifyListeners();
        }
      } else {
        _message = result.message!;
        _resultStatus = ResultStatus.error;
        notifyListeners();
        return;
      }
    } catch (e, trace) {
      print("error $e");
      print("error $trace");

      _message = e.toString();
      _resultStatus = ResultStatus.error;
      notifyListeners();
    }
  }

  Future<void> onChangeMonth(DateTime value) async {
    // final date = value.toLocal();
    //
    // final firstOfMonth = DateTime(value.year, value.month, 1);
    // final lastOfMonth = DateTime(value.year, value.month, 31);
    // final initFrom = DateFormat('yyyy-MM-dd').format(firstOfMonth);
    // final initTo = DateFormat('yyyy-MM-dd').format(lastOfMonth);
    //
    // _dateMonth = DateFormat('MMM yyyy').format(date);
    // notifyListeners();

    _date = value;

    fetchAttendanceHistory(month: value.month, year: value.year);
  }
}

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../constant/constant.dart';
import '../../data/models/attendance_summary.dart';
import '../../data/network/api/api_dashboard.dart';
import '../../ui/util/utils.dart';

class AttendanceSummaryProvider extends ChangeNotifier {
  final ApiDashboard _api = ApiDashboard();

  AttendanceSummary? _attendanceSummary;
  List<ResultAttendanceSummary> _listAttendanceSummary = [];
  ResultStatus _resultStatus = ResultStatus.init;
  String _message = '';
  DateTime _initDate = DateTime.now();

  AttendanceSummary? get attendanceSummary => _attendanceSummary;

  List<ResultAttendanceSummary> get listAttendanceSummary => _listAttendanceSummary;

  ResultStatus get resultStatus => _resultStatus;

  String get message => _message;

  DateTime get initDate => _initDate;

  AttendanceSummaryProvider() {
    fetchAttendancePerson(_initDate);
  }

  Future<void> fetchAttendancePerson(DateTime date) async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    // _linkServer = await getLink();
    try {
      final dateFormat = formatDateYearMont(date);
      Map<String, dynamic> respTeams = await _api.fetchAttendanceSummaryByDate(requestDate: dateFormat);
      _attendanceSummary = AttendanceSummary.fromJson(respTeams);
      print(_attendanceSummary?.toJson());
      _listAttendanceSummary = _attendanceSummary!.details;
      print(_listAttendanceSummary.length);
      if (_listAttendanceSummary.isEmpty) {
        _resultStatus = ResultStatus.noData;
        notifyListeners();
        return;
      } else {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return;
      }
    } on TimeoutException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = ConstantMessage.errMsgTimeOut;
      notifyListeners();
    } on SocketException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = ConstantMessage.errMsgNoInternet;
      notifyListeners();
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = '${ConstantMessage.errMsg} $e';
      notifyListeners();
    }
  }

  Future<void> changeDate(BuildContext context, int joinDate) async {
    final selected = await showMonthPicker(
      context: context,
      initialDate: _initDate,
      firstDate: DateTime(joinDate),
      lastDate: DateTime.now(),
      // roundedCornersRadius: 24,
      // selectedMonthPadding: 8,
      // selectedMonthTextColor: Colors.white,
    );

    if (selected == null) return;
    _initDate = selected;
    fetchAttendancePerson(selected);
    notifyListeners();
  }
}

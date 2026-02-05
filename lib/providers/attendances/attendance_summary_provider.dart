import 'dart:async';

import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/network/api/api_home.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../constant/constant.dart';
import '../../data/models/response/attendance_summary_model.dart';
import '../../injection.dart';

class AttendanceSummaryProvider extends ChangeNotifier {
  final ApiHome _api = ApiHome();
  final _prefs = sl<SharedPreferences>();

  DateTime _initDate = DateTime.now().toLocal();
  AttendanceSummaryModel? _attendanceSummaryModel;
  ResultStatus _resultStatus = ResultStatus.init;
  String _message = '';

  DateTime get initDate => _initDate;
  ResultStatus get resultStatus => _resultStatus;
  AttendanceSummaryModel? get attendanceSummaryModel => _attendanceSummaryModel;
  String get message => _message;

  AttendanceSummaryProvider() {
    fetchAttendanceSummary(_initDate);
  }

  Future<void> fetchAttendanceSummary(DateTime date) async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final result = await _api.fetchAttendanceSummary(number ?? "", date.month, date.year);

      if (result.theme == 'success') {
        _attendanceSummaryModel = result.result;
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
      } else {
        _resultStatus = ResultStatus.error;
        _message = result.message!;
        notifyListeners();
      }
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = e.toString();
      notifyListeners();
      return;
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
    fetchAttendanceSummary(selected);
    notifyListeners();
  }
}

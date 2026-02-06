import 'dart:async';

import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/network/api/api_home.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../data/models/response/attendance_summary_model.dart';
import '../../injection.dart';

class AttendanceSummaryProvider extends ChangeNotifier {
  final ApiHome _api = ApiHome();
  final _prefs = sl<SharedPreferences>();

  DateTime _initDate = DateTime.now().toLocal();
  AttendanceSummaryModel? _attendanceSummaryModel;
  List<DetailAttendanceSummary> _listFilterAttendanceSummary = [];

  String _lockFilter = '';
  List<DetailAttendanceSummary> _listFilter = [];
  bool _isFIlter = false;

  ResultStatus _resultStatus = ResultStatus.init;
  String _message = '';

  DateTime get initDate => _initDate;
  ResultStatus get resultStatus => _resultStatus;
  AttendanceSummaryModel? get attendanceSummaryModel => _attendanceSummaryModel;
  List<DetailAttendanceSummary> get listFilterAttendanceSummary => _listFilterAttendanceSummary;
  List<DetailAttendanceSummary> get listFilter => _listFilter;
  bool get isFilter => _isFIlter;
  String get message => _message;
  String get lockFilter => _lockFilter;

  AttendanceSummaryProvider() {
    fetchAttendanceSummary(_initDate);
  }

  Future<void> fetchAttendanceSummary(DateTime date) async {
    defaultFilter();
    _listFilter.clear();
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final result = await _api.fetchAttendanceSummary(number ?? "", date.month, date.year);

      if (result.theme == 'success') {
        _attendanceSummaryModel = result.result;

        for (var item in _attendanceSummaryModel!.details) {
          if (_listFilter.isEmpty) {
            _listFilter.add(item);
          } else {
            if (_listFilter.any((element) => element.status == item.status!)) {
              continue;
            } else {
              _listFilter.add(item);
            }
          }
        }

        _listFilter.sort((a, b) => a.status!.compareTo(b.status!));

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

  Future<void> onChangeMonth(DateTime value) async {
    _initDate = value;

    notifyListeners();

    fetchAttendanceSummary(value);
  }

  void onFilter(String valueFiltering) {
    if (_lockFilter == valueFiltering) {
      defaultFilter();
      notifyListeners();
      return;
    }

    _lockFilter = valueFiltering;
    _isFIlter = true;
    _listFilterAttendanceSummary.clear();
    _listFilterAttendanceSummary.addAll(_attendanceSummaryModel!.details);

    _listFilterAttendanceSummary = _listFilterAttendanceSummary.where((element) => element.status == valueFiltering).toList();

    if (_listFilterAttendanceSummary.isEmpty) {
      _resultStatus = ResultStatus.noData;
    } else {
      _resultStatus = ResultStatus.hasData;
    }

    notifyListeners();
  }

  void defaultFilter() {
    _lockFilter = '';
    _isFIlter = false;
    _listFilterAttendanceSummary.clear();
  }
}

import 'dart:async';
import 'dart:io';

import 'package:easy_hris/data/models/response/overtime_model.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../constant/exports.dart';
import '../../data/network/api/api_overtime.dart';
import '../../injection.dart';

class OvertimeProvider extends ChangeNotifier {
  final ApiOvertime _api = ApiOvertime();
  final _prefs = sl<SharedPreferences>();

  int _year = DateTime.now().toLocal().year;

  List<ResultOvertimeModel> _listOvertime = [];
  int _totalDuration = 0;
  int _totalAmount = 0;
  ResultStatus _resultStatus = ResultStatus.init;

  String _message = '';

  List<ResultOvertimeModel> get listOvertime => _listOvertime;

  ResultStatus get resultStatus => _resultStatus;

  String get message => _message;

  int get totalDuration => _totalDuration;
  int get totalAmount => _totalAmount;

  int get year => _year;

  OvertimeProvider() {
    // _year = _dateNow.year.toString();
    fetchOvertime(_year);
  }

  Future<void> fetchOvertime(int year) async {
    _totalDuration = 0;
    _totalAmount = 0;
    _listOvertime.clear();
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final response = await _api.fetchOvertime(number!, year);
      if (response.theme == 'success') {
        if (response.result!.isEmpty) {
          _resultStatus = ResultStatus.noData;
          notifyListeners();
          return;
        } else {
          _totalAmount = response.totalAmount ?? 0;
          _totalDuration = response.totalDuration ?? 0;
          _listOvertime = response.result!;
          _resultStatus = ResultStatus.hasData;
          notifyListeners();
          return;
        }
      } else {
        _resultStatus = ResultStatus.error;
        _message = response.message!;
        notifyListeners();
      }
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = e.toString();
      notifyListeners();
      return;
    }
  }

  void sumInfo() {
    for (var item in _listOvertime) {
      _totalDuration += int.parse(item.duration ?? '0') ?? 0;
      _totalAmount += item.overtimeAmount ?? 0;
    }
  }

  Future<void> onChangeYear(bool isAdd) async {
    if (isAdd) {
      _year = _year + 1;
    } else {
      _year = _year - 1;
    }
    fetchOvertime(_year);
    notifyListeners();
  }
}

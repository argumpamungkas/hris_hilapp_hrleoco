import 'dart:async';
import 'dart:io';

import 'package:easy_hris/data/models/response/change_day_model.dart';
import 'package:easy_hris/data/models/response/overtime_model.dart';
import 'package:easy_hris/data/network/api/api_change_day.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../constant/exports.dart';
import '../../data/network/api/api_overtime.dart';
import '../../injection.dart';

class ChangeDayProvider extends ChangeNotifier {
  final ApiChangeDay _api = ApiChangeDay();
  final _prefs = sl<SharedPreferences>();

  // final DateTime _dateNow = DateTime.now().toLocal();
  int _year = DateTime.now().toLocal().year;

  List<ChangeDayModel> _listChangeDay = [];
  // int _remaining = 0;
  int _totalDuration = 0;
  int _totalAmount = 0;
  ResultStatus _resultStatus = ResultStatus.init;

  String _message = '';

  List<ChangeDayModel> get listChangeDay => _listChangeDay;

  ResultStatus get resultStatus => _resultStatus;

  String get message => _message;

  int get totalDuration => _totalDuration;
  int get totalAmount => _totalAmount;

  int get year => _year;

  ChangeDayProvider() {
    // _year = _dateNow.year.toString();
    fetchChangeDay(_year);
  }

  Future<void> fetchChangeDay(int year) async {
    _listChangeDay.clear();
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final response = await _api.fetchChangeDay(number!, year);
      if (response.theme == 'success') {
        if (response.result!.isEmpty) {
          _resultStatus = ResultStatus.noData;
          notifyListeners();
          return;
        } else {
          _listChangeDay = response.result!;
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

  // void sumInfo() {
  //   for (var item in _listOvertime) {
  //     _totalDuration += int.parse(item.duration ?? '0') ?? 0;
  //     _totalAmount += item.overtimeAmount ?? 0;
  //   }
  // }

  Future<void> onChangeYear(bool isAdd) async {
    if (isAdd) {
      _year = _year + 1;
    } else {
      _year = _year - 1;
    }
    fetchChangeDay(_year);
    notifyListeners();
  }
}

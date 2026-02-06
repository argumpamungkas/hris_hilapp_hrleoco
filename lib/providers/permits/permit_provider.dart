import 'dart:async';
import 'dart:io';

import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/response/permit_model.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../data/network/api/api_permit.dart';
import '../../injection.dart';

class PermitProvider extends ChangeNotifier {
  ApiPermit api = ApiPermit();
  final _prefs = sl<SharedPreferences>();

  // final DateTime _dateNow = DateTime.now().toLocal();
  int _year = DateTime.now().toLocal().year;

  List<ResultPermitModel> _listPermit = [];
  int _remaining = 0;
  ResultStatus _resultStatus = ResultStatus.init;

  String _message = '';

  List<ResultPermitModel> get listPermit => _listPermit;

  ResultStatus get resultStatus => _resultStatus;

  String get message => _message;

  int get remaining => _remaining;

  int get year => _year;

  PermitProvider() {
    fetchPermit(_year);
  }

  Future<void> fetchPermit(int year) async {
    _remaining = 0;
    _listPermit.clear();
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final response = await api.fetchPermit(number!, year);
      debugPrint("response ${response.toJson()}");
      if (response.theme == 'success') {
        _remaining = response.remaining;
        if (response.result.isEmpty) {
          _resultStatus = ResultStatus.noData;
          notifyListeners();
          return;
        } else {
          _listPermit = response.result;
          _resultStatus = ResultStatus.hasData;
          notifyListeners();
          return;
        }
      } else {
        _resultStatus = ResultStatus.error;
        _message = response.message;
        notifyListeners();
      }
    } on TimeoutException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = errTimeOutMsg;
      notifyListeners();
      return;
    } on SocketException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = errMessageNoInternet;
      notifyListeners();
      return;
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = e.toString();
      notifyListeners();
      return;
    }
  }

  Future<void> onChangeYear(bool isAdd) async {
    print("Addaaaa");
    if (isAdd) {
      _year = _year + 1;
    } else {
      _year = _year - 1;
    }
    fetchPermit(_year);
    notifyListeners();
  }
}

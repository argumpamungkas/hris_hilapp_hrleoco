import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constant/constant.dart';
import '../../data/models/overtime.dart';
import '../../data/network/api/api_overtime.dart';
import '../../ui/util/utils.dart';

class OvertimeDetailProvider extends ChangeNotifier {
  final ApiOvertime _api = ApiOvertime();

  String _transDate = '';
  String _start = '';
  String _end = '';
  String _timeIn = '';
  String _timeOut = '';
  String _message = '';

  String get transDate => _transDate;

  String get start => _start;

  String get end => _end;

  String get timeIn => _timeIn;

  String get timeOut => _timeOut;

  String get message => _message;

  OvertimeDetailProvider(ResultsOvertime resultOvertime) {
    _convert(resultOvertime);
  }

  void _convert(ResultsOvertime resultOvertime) {
    if (resultOvertime.transDate != null) {
      var dateFormatDefautlt = DateFormat("yyyy-MM-dd").parse(resultOvertime.transDate!);
      _transDate = formatCreated(dateFormatDefautlt);
    }

    if (resultOvertime.start != null) {
      var dateFormatDefautlt = DateFormat("HH:mm:ss").parse(resultOvertime.start!);
      _start = formatTimeAttendance(dateFormatDefautlt);
    }

    if (resultOvertime.end != null) {
      var dateFormatDefautlt = DateFormat("HH:mm:ss").parse(resultOvertime.end!);
      _end = formatTimeAttendance(dateFormatDefautlt);
    }

    if (resultOvertime.timeIn != null) {
      var dateFormatDefautlt = DateFormat("HH:mm:ss").parse(resultOvertime.timeIn!);
      _timeIn = formatTimeAttendance(dateFormatDefautlt);
    }

    if (resultOvertime.timeOut != null) {
      var dateFormatDefautlt = DateFormat("HH:mm:ss").parse(resultOvertime.timeOut!);
      _timeOut = formatTimeAttendance(dateFormatDefautlt);
    }

    notifyListeners();
  }

  Future<bool> cancelRequestOvertime(String id) async {
    try {
      Map<String, dynamic> response = await _api.cancelRequestOvertime(id);
      ResponseOvertime responseOvertime = ResponseOvertime.fromJson(response);
      if (responseOvertime.theme == "success") {
        _message = "Data success canceled";
        notifyListeners();
        return true;
      } else {
        _message = responseOvertime.message;
        notifyListeners();
        return false;
      }
    } on TimeoutException catch (_) {
      _message = errTimeOutMsg;
      notifyListeners();
      return false;
    } on SocketException catch (_) {
      _message = errMessageNoInternet;
      notifyListeners();
      return false;
    } catch (e) {
      _message = errMessage;
      notifyListeners();
      return false;
    }
  }
}

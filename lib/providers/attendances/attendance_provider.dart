import 'dart:io';

import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/network/api/api_attendance.dart';
import 'package:flutter/material.dart';

import '../../injection.dart';

class AttendanceProvider extends ChangeNotifier {
  final ApiAttendance _api = ApiAttendance();
  final _prefs = sl<SharedPreferences>();

  String _title = '';
  String _message = '';

  String get title => _title;
  String get message => _message;

  Future<bool> submitAttendances(int location, File photo) async {
    final now = DateTime.now().toLocal();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final transDate = "${now.year}-${now.month}-${now.day}";
      final transTime = "${now.hour}:${now.minute}:${now.second}";

      final result = await _api.submitAttendances(
        number: number ?? "",
        transDate: transDate,
        transTime: transTime,
        location: location.toString(),
        filePhotoAttendance: photo,
      );

      _title = result.title!;
      _message = result.message!;
      notifyListeners();

      if (result.theme == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _title = "Failed";
      _message = e.toString();
      notifyListeners();
      return false;
    }
  }
}

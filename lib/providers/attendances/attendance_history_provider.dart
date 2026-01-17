import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../constant/constant.dart';
import '../../data/models/history_attendance.dart';
import '../../data/network/api/api_attendance.dart';
import '../../ui/util/utils.dart';

class AttendanceHistoryProvider extends ChangeNotifier {
  final ApiAttendance _api = ApiAttendance();

  ResultStatus _resultStatus = ResultStatus.init;
  String _linkServer = '';
  String _message = '';
  List<ResultsHistoryAttendance> _listAttendance = [];

  DateTime _initDate = DateTime.now();

  ResultStatus get resultStatus => _resultStatus;

  String get linkServer => _linkServer;

  String get message => _message;

  DateTime get initDate => _initDate;

  List<ResultsHistoryAttendance> get listAttendance => _listAttendance;

  AttendanceHistoryProvider() {
    fetchHistoryAttendance(_initDate);
  }

  Future<dynamic> fetchHistoryAttendance(DateTime date) async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    _linkServer = await getLink();
    try {
      final date = formatDateYearMont(_initDate);
      Map<String, dynamic> response = await _api.fetchHistoryAttendance(date);
      HistoryAttendance historyAttendance = HistoryAttendance.fromJson(response);
      _listAttendance = historyAttendance.results;
      if (_listAttendance.isEmpty) {
        _resultStatus = ResultStatus.noData;
        notifyListeners();
        return [];
      } else {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return _listAttendance;
      }
    } on TimeoutException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = errTimeOutMsg;
      notifyListeners();
      return false;
    } on SocketException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = errMessageNoInternet;
      notifyListeners();
      return false;
    } catch (e) {
      _resultStatus = ResultStatus.error;
      _message = errMessage;
      notifyListeners();
      return false;
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
      // monthPickerDialogSettings: MonthPickerDialogSettings(
      //   dialogSettings: PickerDialogSettings(
      //     dialogBackgroundColor: Colors.white,
      //     dismissible: false,
      //     dialogRoundedCornersRadius: 16,
      //   ),
      //   // headerSettings: PickerHeaderSettings(
      //   //   headerBackgroundColor: Constant.,
      //   // ),
      //   dateButtonsSettings: PickerDateButtonsSettings(
      //     // selectedMonthBackgroundColor: Constant.colorTeal,
      //     selectedMonthTextColor: Colors.white,
      //     selectedDateRadius: 8,
      //   ),
      // ),
    );

    if (selected == null) return;
    _initDate = selected;
    fetchHistoryAttendance(selected);
    notifyListeners();
  }
}

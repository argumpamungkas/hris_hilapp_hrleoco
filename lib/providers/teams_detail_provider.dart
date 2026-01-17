import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../constant/constant.dart';
import '../data/models/attendance_summary.dart';
import '../data/network/api/api_dashboard.dart';
import '../ui/util/utils.dart';

class TeamsDetailProvider extends ChangeNotifier {
  final ApiDashboard _api = ApiDashboard();

  AttendanceSummary? _attendanceSummary;
  List<ResultAttendanceSummary> _listAttendanceSummary = [];
  ResultStatus _resultStatus = ResultStatus.init;
  String _message = '';
  String _employeeId = '';
  String _nameEmployee = '';
  String _yearsWork = '';
  String _dateSign = '';
  String _imageUrl = '';
  DateTime _initDate = DateTime.now();

  AttendanceSummary? get attendanceSummary => _attendanceSummary;

  List<ResultAttendanceSummary> get listAttendanceSummary => _listAttendanceSummary;

  ResultStatus get resultStatus => _resultStatus;

  String get message => _message;

  DateTime get initDate => _initDate;

  String get nameEmployee => _nameEmployee;

  String get imageUrl => _imageUrl;

  String get yearsWork => _yearsWork;

  String get dateSign => _dateSign;

  TeamsDetailProvider(Map<String, dynamic> dataEmployee) {
    _employeeId = dataEmployee['employeeId'];
    _nameEmployee = dataEmployee['name'];
    _imageUrl = dataEmployee['imageUrl'];
    _yearsWork = dataEmployee['yearsWork'];
    _dateSign = dataEmployee['dateSign'];
    fetchAttendancePerson(_employeeId, _initDate);
  }

  Future<void> fetchAttendancePerson(String employeeId, DateTime date) async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    // _linkServer = await getLink();
    try {
      final dateFormat = formatDateYearMont(date);
      Map<String, dynamic> respTeams = await _api.fetchTeamAttendancePerson(requestDate: dateFormat, employee_id: _employeeId);
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
    } catch (e, trace) {
      print("trae $trace");
      _resultStatus = ResultStatus.error;
      _message = '${ConstantMessage.errMsg} $e';
      notifyListeners();
    }
  }

  Color checkColor(ResultAttendanceSummary items) {
    Color colorStatus;
    if (items.color.toUpperCase() == "GREEN") {
      colorStatus = Colors.greenAccent.shade400;
    } else if (items.color.toUpperCase() == "BLUE") {
      colorStatus = Colors.blueAccent;
    } else if (items.color.toUpperCase() == "ORANGE") {
      colorStatus = Colors.orangeAccent;
    } else if (items.color.toUpperCase() == "PURPLE") {
      colorStatus = Colors.purpleAccent;
    } else if (items.color.toUpperCase() == "PINK") {
      colorStatus = Colors.pinkAccent;
    } else if (items.color.toUpperCase() == "GRAY") {
      colorStatus = Colors.grey;
    } else {
      colorStatus = Colors.redAccent;
    }
    return colorStatus;
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
    fetchAttendancePerson(_employeeId, selected);
    notifyListeners();
  }
}

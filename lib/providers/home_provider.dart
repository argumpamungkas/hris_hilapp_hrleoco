import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/response/attendance_model.dart';
import 'package:easy_hris/data/models/response/config_model.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../constant/constant.dart';
import '../data/models/attendance.dart';
import '../data/models/attendance_summary.dart';
import '../data/models/news.dart';
import '../data/models/response/shift_user_model.dart';
import '../data/network/api/api_home.dart';
import '../injection.dart';
import '../ui/util/utils.dart';

class HomeProvider extends ChangeNotifier {
  final ApiHome _api = ApiHome();
  final _prefs = sl<SharedPreferences>();

  String _linkServer = '';
  // ResultStatus _resultStatus = ResultStatus.init;
  ResultStatus _resultStatus = ResultStatus.hasData;
  ResultStatus _resultStatusLocation = ResultStatus.init;
  ResultStatus _resultStatusAttendanceToday = ResultStatus.init;
  String _address = '';
  String _message = '';
  String _messageAttendanceToday = '';
  bool _canAttendance = false;
  double _radiusDistance = 0;

  ShiftUserModel? _shiftUserModel;
  String _checkIn = '00:00';
  String _checkOut = '00:00';

  late ResultsAttendance _attendanceToday;
  late AttendanceSummary _attendanceSummary;
  List<ResultsNews> _listNews = [];

  String get linkServer => _linkServer;

  ResultStatus get resultStatus => _resultStatus;
  ResultStatus get resultStatusLocation => _resultStatusLocation;
  ResultStatus get resultStatusAttendanceToday => _resultStatusAttendanceToday;

  String get address => _address;
  String get message => _message;
  String get messageAttendanceToday => _messageAttendanceToday;
  String get checkIn => _checkIn;
  String get checkOut => _checkOut;

  ShiftUserModel? get shiftUserModel => _shiftUserModel;

  bool get canAttendance => _canAttendance;

  ResultsAttendance get attendanceToday => _attendanceToday;

  AttendanceSummary get attendanceSummary => _attendanceSummary;

  List<ResultsNews> get listNews => _listNews;

  double get radiusDistance => _radiusDistance;

  HomeProvider(ConfigModel configModel) {
    init();
    fetchCurrentLocation(configModel);
  }

  Future<void> init() async {
    _resultStatusAttendanceToday = ResultStatus.loading;
    notifyListeners();

    try {
      await Future.wait([fetchShift(), fetchAttendanceToday()]);

      _resultStatusAttendanceToday = ResultStatus.hasData;
      notifyListeners();
    } catch (e) {
      _resultStatusAttendanceToday = ResultStatus.error;
      notifyListeners();
    }
  }

  Future<void> fetchShift() async {
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final result = await _api.fetchShiftUser(number ?? "");

      if (result.theme == 'success') {
        _shiftUserModel = result.result!;
        return;
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

  Future<void> fetchAttendanceToday() async {
    final now = DateTime.now().toLocal();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final transDate = "${now.year}-${now.month}-${now.day}";
      final result = await _api.fetchAttendanceData(number ?? "", transDate, transDate);
      final data = result.result;

      if (data!.isNotEmpty) {
        for (var item in data) {
          if (item.location == '1') {
            _checkIn = item.transTime!;
          }

          if (item.location == '2') {
            _checkOut = item.transTime!;
          }
        }
      }
    } catch (e) {
      return;
    }
  }

  Future<bool> fetchCurrentLocation(ConfigModel configModel) async {
    _resultStatusLocation = ResultStatus.loading;
    notifyListeners();

    if (configModel.latitude == "0" || configModel.longitude == "0" || configModel.radius == "0") {
      _message = "Something wrong as coordinate location company.";
      _resultStatusLocation = ResultStatus.error;
      // _canAttendance = false;
      notifyListeners();
      return false;
    }

    final latCompany = double.tryParse(configModel.latitude ?? '0');
    final longCompany = double.tryParse(configModel.longitude ?? '0');
    final maxRadius = double.tryParse(configModel.radius ?? '0');

    if (latCompany == null || longCompany == null || maxRadius == null) {
      _message = "Invalid company location data.";
      _resultStatusLocation = ResultStatus.error;
      // _canAttendance = false;
      notifyListeners();
      return false;
    }

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _message = "Your GPS inactive";
      _resultStatusLocation = ResultStatus.error;
      // _canAttendance = false;
      notifyListeners();
      return false;
    }

    try {
      final location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium, timeLimit: Duration(seconds: 15));

      // final place = await placemarkFromCoordinates(location.latitude, location.longitude);
      //
      // final p = place.first;
      // _address = [p.street, p.subLocality, p.locality, p.administrativeArea, p.postalCode, p.country].where((e) => e != null).join(', ');

      final distance = Geolocator.distanceBetween(location.latitude, location.longitude, latCompany!, longCompany!);

      if (distance <= maxRadius!.toDouble()) {
        // _canAttendance = true;
        _message = "Your location can do Attendance. Click next for Attendance";
        notifyListeners();
        return true;
      } else {
        final distanceInMeter = distance.toStringAsFixed(0);
        _message = "Your current location is outside the office radius. You are $distanceInMeter meters away from the allowed area.";
        notifyListeners();
        // _radiusDistance = distance;
        // _canAttendance = false;
        return false;
      }

      _resultStatusLocation = ResultStatus.hasData;
      notifyListeners();
    } on TimeoutException catch (_) {
      _message = "Failed get your Location. Check GPS and Connection Device.";
      // _resultStatusLocation = ResultStatus.error;
      // _canAttendance = false;
      notifyListeners();
      return false;
    } on SocketException catch (_) {
      _message = ConstantMessage.errMsgNoInternet;
      // _resultStatusLocation = ResultStatus.error;
      // _canAttendance = false;
      notifyListeners();
      return false;
    } catch (e, trace) {
      // print("error $e");
      // _resultStatusLocation = ResultStatus.error;
      // _canAttendance = false;
      _message = "Something wrong get location. $e";
      notifyListeners();
      return false;
    }
  }
}

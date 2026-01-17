import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../constant/constant.dart';
import '../data/models/attendance.dart';
import '../data/models/attendance_summary.dart';
import '../data/models/news.dart';
import '../data/network/api/api_home.dart';
import '../ui/util/utils.dart';

class HomeProvider extends ChangeNotifier {
  final ApiHome _api = ApiHome();

  String _linkServer = '';
  // ResultStatus _resultStatus = ResultStatus.init;
  ResultStatus _resultStatus = ResultStatus.hasData;
  ResultStatus _resultStatusLocation = ResultStatus.init;
  String _address = '';
  String _message = '';
  bool _canAttendance = false;

  late ResultsAttendance _attendanceToday;
  late AttendanceSummary _attendanceSummary;
  List<ResultsNews> _listNews = [];

  String get linkServer => _linkServer;

  ResultStatus get resultStatus => _resultStatus;
  ResultStatus get resultStatusLocation => _resultStatusLocation;

  String get address => _address;
  String get message => _message;

  bool get canAttendance => _canAttendance;

  ResultsAttendance get attendanceToday => _attendanceToday;

  AttendanceSummary get attendanceSummary => _attendanceSummary;

  List<ResultsNews> get listNews => _listNews;

  HomeProvider() {
    fetchCurrentLocation();
  }

  Future<void> fetchCurrentLocation() async {
    _resultStatusLocation = ResultStatus.loading;
    notifyListeners();

    await Future.delayed(Duration(seconds: 3));

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _message = "Your gps inactive";
      return;
    }

    try {
      final location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium, timeLimit: Duration(seconds: 15));

      final place = await placemarkFromCoordinates(location.latitude, location.longitude);

      final p = place.first;
      _address = [p.street, p.subLocality, p.locality, p.administrativeArea, p.postalCode, p.country].where((e) => e != null).join(', ');

      final radius = 100;

      final distance = Geolocator.distanceBetween(location.latitude, location.longitude, 123, 123);

      _canAttendance = true;

      _resultStatusLocation = ResultStatus.hasData;
      notifyListeners();
    } on TimeoutException catch (_) {
      _message = "Failed get your Location. Check GPS and Connection Device.";
      _resultStatusLocation = ResultStatus.error;
      _canAttendance = false;
      notifyListeners();
      return;
    } on SocketException catch (_) {
      _message = ConstantMessage.errMsgNoInternet;
      _resultStatusLocation = ResultStatus.error;
      _canAttendance = false;
      notifyListeners();
      return;
    } catch (e, trace) {
      print("error $e");
      _resultStatusLocation = ResultStatus.error;
      _canAttendance = false;
      _message = "Something wrong get location. $e";
      notifyListeners();
      return;
    }
  }

  Future<void> fetchHome() async {
    // print("CALL");
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    _linkServer = await getLink();

    try {
      var response = await _api.fetchHomeApi();
      Attendance attendance = Attendance.fromJson(jsonDecode(response[0].body));
      _attendanceToday = attendance.results;
      // =================
      _attendanceSummary = AttendanceSummary.fromJson(jsonDecode(response[1].body));

      // print("aattendance summary ${_attendanceSummary.toJson()}");

      // =================
      News news = News.fromJson(jsonDecode(response[2].body));
      _listNews = news.results;
      _resultStatus = ResultStatus.hasData;
      notifyListeners();
    } on TimeoutException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = errTimeOutMsg;
      notifyListeners();
    } on SocketException catch (_) {
      _resultStatus = ResultStatus.error;
      _message = errMessageNoInternet;
      notifyListeners();
    } catch (e, trace) {
      print("ERROR $e");
      print("ERROR $trace");
      _resultStatus = ResultStatus.error;
      _message = "$errMessage. $e";
      notifyListeners();
    }
  }
}

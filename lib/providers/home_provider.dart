import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/response/announcement_model.dart';
import 'package:easy_hris/data/models/response/attendance_model.dart';
import 'package:easy_hris/data/models/response/attendance_summary_model.dart';
import 'package:easy_hris/data/models/response/config_model.dart';
import 'package:easy_hris/data/models/response/permit_today_model.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../constant/constant.dart';
import '../data/models/attendance.dart';
import '../data/models/attendance_summary.dart';
import '../data/models/news.dart';
import '../data/models/response/shift_user_model.dart';
import '../data/network/api/api_home.dart';
import '../data/services/notification_services.dart';
import '../injection.dart';
import '../ui/util/utils.dart';

class HomeProvider extends ChangeNotifier {
  final ApiHome _api = ApiHome();
  final _prefs = sl<SharedPreferences>();
  final _notifService = NotificationServices();

  // ResultStatus _resultStatus = ResultStatus.init;
  ResultStatus _resultStatus = ResultStatus.hasData;
  ResultStatus _resultStatusLocation = ResultStatus.init;
  ResultStatus _resultStatusAttendanceToday = ResultStatus.init;
  ResultStatus _resultStatusAttendanceSummary = ResultStatus.init;
  ResultStatus _resultStatusPermitToday = ResultStatus.init;
  ResultStatus _resultStatusAnnouncement = ResultStatus.init;

  String _address = '';
  String _message = '';
  String _messageAttendanceToday = '';
  String _messageAttendanceSummary = '';
  String _messagePermitToday = '';
  String _messageAnnouncement = '';

  bool _canAttendance = false;
  double _radiusDistance = 0;

  // Attendance Today
  ShiftUserModel? _shiftUserModel;
  String _checkIn = '00:00:00';
  String _checkOut = '00:00:00';

  // AttendanceSummary
  AttendanceSummaryModel? _attendanceSummaryModel;

  // Permission Today
  List<PermitTodayModel> _listPermitToday = [];

  // Announcement
  List<AnnouncementModel> _listAnnouncement = [];

  // Result Status
  ResultStatus get resultStatus => _resultStatus;
  ResultStatus get resultStatusLocation => _resultStatusLocation;
  ResultStatus get resultStatusAttendanceToday => _resultStatusAttendanceToday;
  ResultStatus get resultStatusAttendanceSummary => _resultStatusAttendanceSummary;
  ResultStatus get resultStatusPermitToday => _resultStatusPermitToday;
  ResultStatus get resultStatusAnnouncement => _resultStatusAnnouncement;

  String get address => _address;
  String get message => _message;
  String get messageAttendanceToday => _messageAttendanceToday;
  String get messageAttendanceSummary => _messageAttendanceSummary;
  String get messagePermitToday => _messagePermitToday;
  String get messageAnnouncement => _messageAnnouncement;

  ShiftUserModel? get shiftUserModel => _shiftUserModel;
  String get checkIn => _checkIn;
  String get checkOut => _checkOut;
  AttendanceSummaryModel? get attendanceSummaryModel => _attendanceSummaryModel;
  List<PermitTodayModel> get listPermitToday => _listPermitToday;
  List<AnnouncementModel> get listAnnouncement => _listAnnouncement;

  bool get canAttendance => _canAttendance;

  double get radiusDistance => _radiusDistance;

  HomeProvider(ConfigModel configModel) {
    fetching(configModel);
  }

  // TODO : Call ALl Function
  Future<void> fetching(ConfigModel configModel) async {
    print("object");
    init();
    fetchCurrentLocation(configModel);
    fetchAttendanceSummary();
    fetchPermissionToday();
    fetchAnnouncement();
  }

  // TODO : Shift dan attendance Today jadi kesatuan
  Future<void> init() async {
    print("callll");
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

  // TODO : Fetch Shift
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

  // TODO : Fetch Attendance Today
  Future<void> fetchAttendanceToday() async {
    final now = DateTime.now().toLocal();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final transDate = "${now.year}-${now.month}-${now.day}";
      final result = await _api.fetchAttendanceToday(number ?? "", transDate);
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

  // TODO : Fetch current Location
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

      if (location.isMocked) {
        _message = "Fake GPS detected!";
        notifyListeners();
        return false;
      }

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

  // TODO : Attendance SUmmary
  Future<void> fetchAttendanceSummary() async {
    _resultStatusAttendanceSummary = ResultStatus.loading;
    notifyListeners();
    final now = DateTime.now().toLocal();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final month = now.month;
      final year = now.year;
      final result = await _api.fetchAttendanceSummary(number ?? "", month, year);

      if (result.theme == 'success') {
        _attendanceSummaryModel = result.result;
        _resultStatusAttendanceSummary = ResultStatus.hasData;
        notifyListeners();
      } else {
        _resultStatusAttendanceSummary = ResultStatus.error;
        _messageAttendanceSummary = result.message!;
        notifyListeners();
      }
    } catch (e) {
      _resultStatusAttendanceSummary = ResultStatus.error;
      _messageAttendanceSummary = e.toString();
      notifyListeners();
      return;
    }
  }

  Future<void> fetchPermissionToday() async {
    _resultStatusPermitToday = ResultStatus.loading;
    notifyListeners();
    final now = DateTime.now().toLocal();
    try {
      final result = await _api.fetchPermitToday();

      if (result.theme == 'success') {
        if (result.result!.isEmpty) {
          _resultStatusPermitToday = ResultStatus.noData;
          notifyListeners();
        } else {
          _listPermitToday = result.result!;
          _resultStatusPermitToday = ResultStatus.hasData;
          _messagePermitToday = 'Permission Today is Empty';
          notifyListeners();
        }
      } else {
        _resultStatusPermitToday = ResultStatus.error;
        _messagePermitToday = result.message!;
        notifyListeners();
      }
    } catch (e) {
      _resultStatusPermitToday = ResultStatus.error;
      _messagePermitToday = e.toString();
      notifyListeners();
      return;
    }
  }

  Future<void> fetchAnnouncement() async {
    _resultStatusAnnouncement = ResultStatus.loading;
    notifyListeners();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final result = await _api.fetchAnnouncement(number ?? '');

      if (result.theme == 'success') {
        if (result.result!.isEmpty) {
          _resultStatusAnnouncement = ResultStatus.noData;
          notifyListeners();
        } else {
          _listAnnouncement = result.result!;
          _resultStatusAnnouncement = ResultStatus.hasData;
          _messageAnnouncement = 'Permission Today is Empty';
          notifyListeners();
        }
      } else {
        _resultStatusAnnouncement = ResultStatus.error;
        _messageAnnouncement = result.message!;
        notifyListeners();
      }
    } catch (e) {
      _resultStatusAnnouncement = ResultStatus.error;
      _messageAnnouncement = e.toString();
      notifyListeners();
      return;
    }
  }

  Future<bool> prepareSaveDir(AnnouncementModel announcement, int index) async {
    String localPath = '';
    Dio dio = Dio();
    final typeFile = announcement.attachment?.split('.').last;
    print("type file $typeFile");
    String name = "${announcement.title}.$typeFile";
    String nameFile = name.replaceAll(' ', '_');

    if (Platform.isAndroid) {
      var infoDevice = await DeviceInfoPlugin().androidInfo;
      if (infoDevice.version.sdkInt > 28) {
        localPath = Directory("/storage/emulated/0/Download").path;
      } else {
        localPath = '/storage/emulated/0/Download';
      }
    } else {
      final directory = await getApplicationDocumentsDirectory();
      localPath = directory.path;
    }

    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create(recursive: true);
    }

    try {
      final filePath = "$localPath/$nameFile";
      // int notificationId = int.parse(dateNotifId);
      int notificationId = index;

      await dio.download(
        announcement.attachment!,
        filePath,
        onReceiveProgress: (count, total) async {
          if (total != -1) {
            final progress = (count / total * 100).floor();

            await _notifService.showNotificationProgressDownload(notificationId, progress);
          }
        },
      );
      await Future.delayed(Duration(milliseconds: 1500));

      await _notifService.notificationCancel(notificationId);

      await Future.delayed(Duration(milliseconds: 1000));

      await _notifService.showNotificationSuccessDownload(notificationId, filePath, nameFile);

      return true;
    } catch (e, trace) {
      print("Error $e");
      print("Trace $trace");
      return false;
    }
  }
}

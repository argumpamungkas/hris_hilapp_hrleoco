import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constant/constant.dart';
import '../../../data/models/attendance.dart';
import '../../../data/network/api/api_attendance.dart';
import '../../util/utils.dart';

class AttendanceController with ChangeNotifier {
  ApiAttendance _apiAttendance = ApiAttendance();

  bool _hasPermission = false;
  late String? _address;
  double? _latUser;
  double? _longUser;
  bool _loading = false;

  String _message = '';
  String _companyCode = '';

  ResultStatus _resultStatus = ResultStatus.init;

  double? get latUser => _latUser;

  double? get longUser => _longUser;

  ResultStatus get resultStatus => _resultStatus;

  bool get hasPermission => _hasPermission;

  String? get address => _address;

  Future<bool> attendanceUser(
    File pathPicture,
    ResultsAttendance attendanceToday,
    // String location,
  ) async {
    if (attendanceToday.timeIn == null || attendanceToday.timeIn!.isEmpty) {
      // print("KESINI");
      bool response = await sendAttendanceIn(pathPicture);
      if (!response) {
        return false;
      } else {
        return true;
      }
    } else {
      // print("KESINI OUT");
      var response = await sendAttendanceOut(
        pathPicture,
        attendanceToday.dateIn!,
        attendanceToday.timeIn!,
        // location,
      );
      if (!response) {
        return false;
      } else {
        return true;
      }
    }
  }

  Future<bool> checkLocationAttendance({required String latitude, required String longitude}) async {
    try {
      final result = await _apiAttendance.checkLocationAttendance(latitude: latitude, longitude: longitude);
      final status = result['theme'];
      if (status == 'success') {
        _companyCode = result['data']['company_code'];
        // print("Company code $_companyCode");
        return true;
      } else {
        _message = result['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _message = "$e";
      return false;
    }
  }

  Future<bool> checkLocation(BuildContext context, ResultsAttendance attendanceToday) async {
    if (!hasPermission) {
      showFailSnackbar(context, "Location not granted permission, Refresh your Location");
      return false;
    }

    if (attendanceToday.timeIn != null && attendanceToday.timeOut != null) {
      // debugPrint("${attendanceToday.timeIn} - ${attendanceToday.timeOut}");
      showInfoSnackbar(context, "Today your attendance is complete");
      return false;
    }

    if (_latUser == null || _longUser == null) {
      showFailSnackbar(context, "Your location is not suitable");
    }

    if (_address!.isEmpty || _address == null) {
      showFailSnackbar(context, "Your location is not suitable");
      return false;
    }

    if (_loading) {
      showFailSnackbar(context, "Process get your location");
      return false;
    }
    //
    // if (latOffice == null && longOffice == null) {
    //   showFailSnackbar(
    //     context,
    //     "Choose Location for Attendance",
    //   );
    //   return false;
    // }

    // print("Lat user $latUser");
    // print("Long user $longUser");

    final result = await checkLocationAttendance(latitude: _latUser.toString(), longitude: _longUser.toString());
    if (!result) {
      showFailSnackbar(context, _message.toString());
      return false;
    }

    // print('LATITUDE : $_latUser, LONGITUDE : $_longUser');

    // _latUser = -6.8991357;
    // _longUser = 107.5614365;

    // double distanceInMeter = GeolocatorPlatform.instance.distanceBetween(
    //   _latUser!,
    //   _longUser!,
    //   latOffice!,
    //   longOffice!,
    // );

    // debugPrint("NEW $latOffice + $longOffice");

    // if (distanceInMeter > radius!) {
    //   showFailSnackbar(
    //     context,
    //     "Your location is outside the attendance radius, the distance is ${distanceInMeter.toStringAsFixed(1)} M. Radius Attendance is $radius M from office.",
    //     action: SnackBarAction(
    //         label: "Open Maps",
    //         textColor: Colors.white,
    //         backgroundColor: Colors.orange,
    //         onPressed: () async {
    //           final url =
    //               "https://www.google.com/maps/dir/?api=1&origin=$_latUser,$_longUser&destination=$latOffice,$longOffice&travelmode=driving";
    //           try {
    //             await launchUrl(Uri.parse(url));
    //           } catch (e) {
    //             if (!context.mounted) return;
    //             showFailSnackbar(context, "Failed to redirect Google Maps");
    //           }
    //           // MapsLauncher.launchCoordinates(_latUser!, _longUser!, "Your Location");
    //         }),
    //   );
    //   return false;
    // }

    return true;
  }

  Future<void> getPermission(BuildContext context) async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    if (!hasPermission) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      var locationStatus = await Permission.location.status;
      if (serviceEnabled) {
        if (locationStatus.isDenied) {
          LocationPermission locationPermission = await Geolocator.requestPermission();
          if (locationPermission == LocationPermission.denied) {
            if (!context.mounted) return;
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const AlertDialog(title: Text("Warning"), content: Text("Location not granted permission"));
              },
            );
            _resultStatus = ResultStatus.hasData;
            notifyListeners();
            Future.delayed(const Duration(milliseconds: 1500), () => Navigator.pop(context));
          } else {
            _resultStatus = ResultStatus.hasData;
            if (!context.mounted) return;
            await getLocation(context);
            _hasPermission = true;
            notifyListeners();
          }
        } else {
          _resultStatus = ResultStatus.hasData;
          if (!context.mounted) return;
          await getLocation(context);
          _hasPermission = true;
          notifyListeners();
        }
      } else {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        if (!context.mounted) return;
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const AlertDialog(title: Text("Warning"), content: Text("To get your current location, please activate your GPS.")),
        );
        Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));
      }
    } else {
      _resultStatus = ResultStatus.hasData;
      if (!context.mounted) return;
      await getLocation(context);
      _hasPermission = true;
      notifyListeners();
    }
  }

  Future<dynamic> getLocation(BuildContext context) async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    _loading = true;
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 10),
    );

    if (position.isMocked) {
      if (!context.mounted) return;
      showInfoDialog(
        context,
        titleSuccess: "GPS",
        descriptionSuccess: "You detected using fake gps.",
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
      return;
    }

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? addressStreet = placemarks[2].street;
    String? addressLocality = placemarks.first.locality;
    String? addressSubAdministrativeArea = placemarks.first.subAdministrativeArea;

    _latUser = position.latitude;
    _longUser = position.longitude;
    _address = "$addressStreet, $addressLocality, $addressSubAdministrativeArea";

    _loading = false;
    _resultStatus = ResultStatus.hasData;
    notifyListeners();
    return _address;
  }

  Future<dynamic> sendAttendanceIn(File pathPicture) async {
    var now = DateTime.now();
    String dateIn = DateFormat("yyyy-MM-dd").format(now);
    String timeIn = DateFormat("HH:mm:ss").format(now);
    try {
      var response = await _apiAttendance.sendAttendanceIn(
        dateIn,
        timeIn,
        pathPicture,
        _companyCode,
        // location,
      );
      var status = response['theme'];
      if (status == 'error') {
        notifyListeners();
        return false;
      } else {
        notifyListeners();
        return true;
      }
    } catch (e) {
      // print("ERROR $e");
      notifyListeners();
      return false;
    }
  }

  Future<dynamic> sendAttendanceOut(File pathPicture, String dateIn, String timeIn) async {
    var now = DateTime.now();
    String dateOut = DateFormat("yyyy-MM-dd").format(now);
    String timeOut = DateFormat("HH:mm:ss").format(now);
    try {
      var response = await _apiAttendance.sendAttendanceOut(
        dateIn,
        dateOut,
        timeIn,
        timeOut,
        pathPicture,
        _companyCode,
        // location,
      );
      var status = response['theme'];
      if (status == 'error') {
        notifyListeners();
        return false;
      } else {
        notifyListeners();
        return true;
      }
    } catch (e) {
      // print("ERROR $e");
      notifyListeners();
      return false;
    }
  }

  void clearData() {
    _latUser = null;
    _longUser = null;
    _loading = false;
    _hasPermission = false;
  }
}

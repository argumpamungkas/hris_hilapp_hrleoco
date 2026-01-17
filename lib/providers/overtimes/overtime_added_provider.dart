import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../constant/constant.dart';
import '../../data/models/overtime.dart';
import '../../data/network/api/api_attendance.dart';
import '../../data/network/api/api_overtime.dart';
import '../../data/services/images_services.dart';
import '../../ui/util/utils.dart';

class OvertimeAddedProvider extends ChangeNotifier {
  final ApiOvertime _apiOvertime = ApiOvertime();
  final ApiAttendance _apiAttendance = ApiAttendance();
  final _imagesServices = ImagesServices();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _requestDateController = TextEditingController();
  final TextEditingController _sendRequestDateController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _breakController = TextEditingController();
  final TextEditingController _mealController = TextEditingController();
  final TextEditingController _planController = TextEditingController();
  final TextEditingController _actualController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  XFile? _selectImage;
  bool _isMeal = false;
  int _dateStart = 0;
  bool _readOnlyStart = false;
  bool _readOnlyEnd = false;
  bool _readOnlyPlan = false;

  late DateTime _firstDate;
  final _now = DateTime.now().toLocal();
  final _timeNow = TimeOfDay.now();
  String _infoFile = "File Max 1 MB";

  ResultStatus _resultStatus = ResultStatus.init;

  ResultStatus get resultStatus => _resultStatus;

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController get requestDateController => _requestDateController;

  TextEditingController get sendRequestDateController => _sendRequestDateController;

  TextEditingController get startController => _startController;

  TextEditingController get endController => _endController;

  TextEditingController get breakController => _breakController;

  TextEditingController get mealController => _mealController;

  TextEditingController get planController => _planController;

  TextEditingController get actualController => _actualController;

  TextEditingController get remarksController => _remarksController;

  XFile? get selectImage => _selectImage;

  bool get isMeal => _isMeal;

  int get dateStart => _dateStart;

  bool get readOnlyStart => _readOnlyStart;

  bool get readOnlyEnd => _readOnlyEnd;

  bool get readOnlyPlan => _readOnlyPlan;

  DateTime get firstDate => _firstDate;

  String get infoFile => _infoFile;

  // OvertimeAddController() {
  // fetchCutOff();
  // }

  onChangeMeal(bool value) {
    _isMeal = value;
    isMeal ? _mealController.text = "Meal" : _mealController.text = "-";
    notifyListeners();
  }

  onChangedBreak(String value) {
    if (_planController.text.isNotEmpty) {
      final result = int.parse(planController.text) - int.parse(breakController.text);
      if (result >= 0) {
        _actualController.text = result.toString();
      } else {
        _actualController.text = "0";
      }
    }
    notifyListeners();
  }

  void openCalendar(BuildContext context) async {
    final lastDate = DateTime(_now.year + 1, _now.month, _now.day);

    _firstDate = DateTime(_now.year, _now.month - 1, 1).toLocal();
    final selected = await showDatePicker(context: context, initialDate: _now, firstDate: firstDate, lastDate: lastDate);

    if (selected != null) {
      var sendDate = DateFormat("yyyy-MM-dd").format(selected);
      _requestDateController.text = DateFormat("dd MMMM yyyy").format(selected);
      _sendRequestDateController.text = formatDateAttendance(selected);
      // final month = selected.month < _now.month;
      // final day = selected.day < _now.day;

      if (!context.mounted) return;
      showLoadingDialog(context);
      await fetchAttendanceByDate(context, sendDate);
      notifyListeners();
    }
  }

  Future<void> fetchAttendanceByDate(BuildContext context, String sendDate) async {
    try {
      final result = await _apiOvertime.overtimeSummary(sendDate);
      // print("RESULT by date $result");
      // final reqDate = _requestDateController.text;
      if (result['date_time'] == null) {
        if (!context.mounted) return;
        Navigator.pop(context);
        showFailedDialog(context, titleFailed: "Overtime", descriptionFailed: "Sorry your attendance not available, confirm HR to Generated Absence");
        _clearController(); // clear controller
        notifyListeners();
      } else {
        if (result['time_out'] == null || result['time_in'] == null) {
          if (!context.mounted) return;
          Navigator.pop(context);
          showFailedDialog(
            context,
            titleFailed: "Overtime",
            descriptionFailed: "Sorry your attendance not available, confirm HR to Generated Absence",
          );
          _clearController(); // clear controller
          notifyListeners();
        } else {
          if (!context.mounted) return;
          Navigator.pop(context);

          var dateFormatIn = DateFormat("HH:mm:ss").parse(result['time_in']!);
          _startController.text = formatTimeAttendance(dateFormatIn);
          var dateFormatOut = DateFormat("HH:mm:ss").parse(result['time_out']!);
          _endController.text = formatTimeAttendance(dateFormatOut);

          _planController.text = result['plan'].toString();
          _actualController.text = result['actual'].toString();
          _breakController.text = result['breaks'].toString();

          _readOnlyStart = true;
          _readOnlyEnd = true;
          _readOnlyPlan = true;
          notifyListeners();
        }
      }
      // print("RESULT $result");
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      showFailSnackbar(context, "Something wrong, $e");
    }
  }

  void openGallery() async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      try {
        final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);

        if (selectedImage == null) return;
        var file = File(selectedImage.path);

        // Cek extension
        if (selectedImage.path.toLowerCase().endsWith(".heic")) {
          final newPath = selectedImage.path.replaceAll(".heic", ".jpg");
          file = await _imagesServices.convertToJpgOrPng(file, newPath);
        }

        _selectImage = XFile(file.path);

        var bytes = (await _selectImage!.readAsBytes()).lengthInBytes;

        if (bytes > 1000000) {
          _infoFile = "File too large, max 1 MB";
          notifyListeners();
          return;
        }

        // _selectImage = selectedImage;
        notifyListeners();
        return;
      } catch (e) {
        _infoFile = "Error open gallery. $e";
        notifyListeners();
        return;
      }
    }
  }

  Future<void> openCamera() async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      final XFile? selectedImage = await picker.pickImage(source: ImageSource.camera, imageQuality: 25);

      if (selectedImage == null) return;
      // var bytes = (await selectedImage.readAsBytes()).lengthInBytes;
      // if (bytes > 1000000) {
      //   _infoFile = "File too large, max 1 MB";
      //   notifyListeners();
      //   return;
      // }

      var file = File(selectedImage.path);

      // Cek extension
      if (selectedImage.path.toLowerCase().endsWith(".heic")) {
        final newPath = selectedImage.path.replaceAll(".heic", ".jpg");
        file = await _imagesServices.convertToJpgOrPng(file, newPath);
      }

      _selectImage = XFile(file.path);
      notifyListeners();
      return;
    } else {
      _infoFile = "Error open camera.";
      notifyListeners();
      return;
    }
  }

  //
  void openTimeStart(BuildContext context) async {
    TimeOfDay? selected = await showTimePicker(context: context, initialTime: _timeNow);

    if (selected != null) {
      if (!context.mounted) return;
      final h = selected.hour.toString().padLeft(2, '0');
      final m = selected.minute.toString().padLeft(2, '0');
      _startController.text = "$h:$m";
      // _startController.text = selected.format(context);
      _calculateBreak();
      notifyListeners();
    }
  }

  void openTimeEnd(BuildContext context) async {
    TimeOfDay? selected = await showTimePicker(context: context, initialTime: _timeNow);

    if (selected != null) {
      if (!context.mounted) return;
      final h = selected.hour.toString().padLeft(2, '0');
      final m = selected.minute.toString().padLeft(2, '0');
      _endController.text = "$h:$m";
      // _endController.text = selected.format(context);
      _calculateBreak();

      // print("time start => ${startController.text}");
      // print("time end => ${endController.text}");

      final format = DateFormat.Hm(); // "HH:mm" format

      final start = format.parse(startController.text);
      final end = format.parse(endController.text);
      final difference = end.difference(start).inMinutes;
      final planCalculate = calculateMinutes(difference);
      _planController.text = planCalculate.toString();

      notifyListeners();
    }
  }

  String getDayName(String dateString) {
    DateTime date = DateTime.parse(dateString); // format: YYYY-MM-DD
    return DateFormat('EEEE').format(date);
  }

  void _calculateBreak() {
    if (_startController.text.isNotEmpty && _endController.text.isNotEmpty) {
      // Format waktu
      final format = DateFormat.Hm(); // Format seperti "10:00 AM"

      // Konversi string ke DateTime
      DateTime startTime = format.parse(_startController.text.trim());
      DateTime endTime = format.parse(_endController.text.trim());

      if (endTime.isBefore(startTime)) {
        endTime = endTime.add(const Duration(days: 1));
      }

      // Hitung selisih dalam jam
      Duration workDuration = endTime.difference(startTime);
      double totalHours = workDuration.inMinutes / 60; // Konversi ke jam

      // Hitung jumlah break (setiap 5 jam kerja dapat 30 menit istirahat)
      int numBreaks = (totalHours / 5).floor();
      Duration totalBreakTime = Duration(minutes: numBreaks * 60);

      if (totalBreakTime.inMinutes < 0) {
        _breakController.text = 0.toString();
      } else {
        final totalBreak = calculateMinutes(totalBreakTime.inMinutes);
        _breakController.text = totalBreak.toString();
      }
    }
  }

  DateTime parseDateTime(String date, String time) {
    return DateTime.parse("$date $time");
  }

  // void _calculateWeekend(Map<String, dynamic> result) {
  //   DateTime timeIn = parseDateTime(result['date_time'], result['time_in']);
  //   DateTime timeOut = parseDateTime(result['date_time'], result['time_out']);
  //
  //   // Hitung selisih dalam menit
  //   final differenceMinutes = timeOut.difference(timeIn).inMinutes;
  //
  //   // Konversi menit → jam (desimal atau bulat, sesuai kebutuhan)
  //   int totalHours = calculateMinutes(differenceMinutes);
  //
  //   print("TOTAL WEEKEND HOURS $totalHours");
  //
  //   // plan dan actual sama saat weekend
  //   planController.text = totalHours.toString();
  //   actualController.text = totalHours.toString();
  //
  //   // Jika ada break (biasanya weekend tidak ada), tinggal dikurangkan
  //   if (breakController.text.isNotEmpty && planController.text != "0") {
  //     final resultActual = totalHours - int.parse(breakController.text.trim());
  //     actualController.text = resultActual.toString();
  //   }
  // }
  //
  // void _calculatePlanActual(Map<String, dynamic> result) {
  //   DateTime shiftStart =
  //       parseDateTime(result['date_time'], result['shift_start']);
  //   DateTime shiftEnd = parseDateTime(result['date_time'], result['shift_end']);
  //   DateTime timeIn = parseDateTime(result['date_time'], result['time_in']);
  //   DateTime timeOut = parseDateTime(result['date_time'], result['time_out']);
  //
  //   // final checkIn = timeIn.hour * 60 + timeIn.minute;
  //   // final checkOut = timeOut.hour * 60 + timeOut.minute;
  //   // final differenceCheckIn = checkOut +
  //
  //   // final differenceTime = timeOut.difference(timeIn).inMinutes;
  //
  //   // apakah shift start lebih dari time in ? jika ya hitung perbedaan waktu : jika tidak maka 0
  //   int startMinutes = shiftStart.isAfter(timeIn)
  //       ? shiftStart.difference(timeIn).inMinutes
  //       : 0;
  //   //
  //   // print("START MINUTES $startMinutes");
  //   //
  //   int endMinutes =
  //       timeOut.isAfter(shiftEnd) ? timeOut.difference(shiftEnd).inMinutes : 0;
  //   print("END MINUTES $endMinutes");
  //   //
  //   int minutes = startMinutes + endMinutes;
  //   print("MINUTES DIDAPAT $minutes");
  //
  //   // print("DIFFERENCE => $differenceTime");
  //
  //   // hitung berapa jam berdasarkan menit
  //   int actual = calculateMinutes(minutes);
  //   print("HASIL MINUTES $actual");
  //
  //   // plan == actual
  //   planController.text = actual.toString();
  //   actualController.text = actual.toString();
  //
  //   if (planController.text.isNotEmpty && planController.text != "0") {
  //     final resultAct =
  //         int.parse(planController.text) - int.parse(breakController.text);
  //     _actualController.text = resultAct.toString();
  //   }
  // }

  Future<dynamic> addOvertime(BuildContext context) async {
    _isMeal ? _mealController.text = "1" : _mealController.text = "0";
    File? attachment = _selectImage == null ? null : File(_selectImage!.path);
    try {
      print("CALL");

      Map<String, dynamic> response = await _apiOvertime.addOvertime(
        _sendRequestDateController.text,
        _startController.text,
        _endController.text,
        _breakController.text,
        _mealController.text,
        _planController.text,
        _actualController.text,
        attachment,
        _remarksController.text,
      );
      print("RESPONSE ADD OVERTIME $response");
      ResponseOvertime respOvertime = ResponseOvertime.fromJson(response);
      return respOvertime;
    } on TimeoutException catch (_) {
      if (!context.mounted) return;
      Navigator.pop(context);
      showFailedDialog(context, titleFailed: "Failed", descriptionFailed: errTimeOutMsg);
      return;
    } on SocketException catch (_) {
      if (!context.mounted) return;
      Navigator.pop(context);
      showFailedDialog(context, titleFailed: "Failed", descriptionFailed: errMessageNoInternet);
      return;
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      showFailedDialog(context, titleFailed: "Failed", descriptionFailed: errMessage);
      notifyListeners();
      return;
    }
  }

  int calculateMinutes(int minutes) {
    if (minutes < 30) return 0; // jika kurang 30 menit maka akan 0
    // menghitung blok pertama yaitu mulai dari 30 menit
    // jika minutes 89 menit -> 89 - 30 = 59, 59 ~/ 60 = 0, 0 + 1 = 1
    // jadi jika hasil awal akan dibagi 60 (integer division) / bilangan bulat
    int result = ((minutes - 30) ~/ 60) + 1;
    print("RESULT HITUNGAN => $result");
    return result > 23 ? 23 : result;
  }

  void _clearController() {
    _requestDateController.clear();
    _sendRequestDateController.clear();
    _readOnlyStart = false;
    _readOnlyEnd = false;
    _readOnlyPlan = false;
    _startController.clear();
    _endController.clear();
    _breakController.clear();
    _planController.clear();
    _actualController.clear();
    _isMeal = false;
    _remarksController.clear();
  }
}

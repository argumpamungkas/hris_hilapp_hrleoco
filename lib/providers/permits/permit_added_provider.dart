import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../constant/constant.dart';
import '../../data/models/permit.dart';
import '../../data/models/permit_reason.dart';
import '../../data/models/permit_type.dart';
import '../../data/network/api/api_permit.dart';
import '../../data/services/images_services.dart';
import '../../ui/util/utils.dart';

class PermitAddedProvider extends ChangeNotifier {
  final ApiPermit _api = ApiPermit();
  final _imagesServices = ImagesServices();

  ResultStatus _resultStatus = ResultStatus.init;
  String _message = '';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateFromC = TextEditingController();
  final TextEditingController _dateToC = TextEditingController();
  final TextEditingController _sendDateFromC = TextEditingController();
  final TextEditingController _sendDateToC = TextEditingController();
  final TextEditingController _permitAvailableC = TextEditingController();
  final TextEditingController _remarksC = TextEditingController();

  List<PermitType> _listPermitType = [];
  PermitType? _permitType;

  List<PermitReason> _listPermitReason = [];
  String? _permitReason;
  int? _totalAvailable;

  XFile? _selectImage;
  String _info = "File max 1 MB";
  final DateTime _now = DateTime.now().toLocal();

  int _dateStart = 0;

  bool _readOnlyPermitType = false;

  bool _readOnlyPermitReason = false;

  bool get readOnlyPermitType => _readOnlyPermitType;

  bool get readOnlyPermitReason => _readOnlyPermitReason;

  ResultStatus get resultStatus => _resultStatus;

  String get message => _message;

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController get dateFromC => _dateFromC;

  TextEditingController get dateToC => _dateToC;

  TextEditingController get sendDateFromC => _sendDateFromC;

  TextEditingController get sendDateToC => _sendDateToC;

  TextEditingController get permitAvailableC => _permitAvailableC;

  TextEditingController get remarksC => _remarksC;

  List<PermitType> get lisPermitType => _listPermitType;

  PermitType? get permitType => _permitType;

  List<PermitReason> get lisPermitReason => _listPermitReason;

  String? get permitReason => _permitReason;

  int? get totalAvailable => _totalAvailable;

  XFile? get selectImage => _selectImage;

  String get info => _info;

  PermitAddedProvider() {
    _fetchPermitType();
  }

  Future<dynamic> _fetchPermitType() async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      List response = await _api.fetchPermitType();
      _listPermitType = response.map((e) => PermitType.fromJson(e)).toList();
      if (_listPermitType.isEmpty) {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return [];
      } else {
        _resultStatus = ResultStatus.hasData;
        notifyListeners();
        return _listPermitType;
      }
    } catch (e) {
      _message = 'Something wrong Fetching Permit Type';
      _resultStatus = ResultStatus.error;
      notifyListeners();
      return false;
    }
  }

  bool checkPermitType() {
    if (_permitType!.attachment == "YES" && _selectImage == null) {
      return false;
    }
    return true;
  }

  void onClearReason() {
    _permitReason = null;
    notifyListeners();
    _listPermitReason = [];
    _permitAvailableC.clear();
    // notifyListeners();
  }

  Future<bool> fetchPermitReason(PermitType? permitType) async {
    try {
      _permitType = permitType;

      // Reset value dulu sebelum rebuild daftar baru
      // _permitReason = null;
      // _listPermitReason = [];
      // notifyListeners();

      List response = await _api.fetchPermitReason(permitType!.id);
      // print("RESPONSE PERMIT REASON $response");

      final listReas = response.map((e) => PermitReason.fromJson(e)).toSet().toList();

      _listPermitReason.addAll(listReas);

      if (_listPermitReason.isEmpty) {
        _message = 'Permit Reason is Empty';
        notifyListeners();
        return false;
      } else {
        notifyListeners();
        return true;
      }
    } catch (e) {
      _message = 'Something wrong Fetching Permit Reason';
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchPermitAvailable(String valueReason) async {
    _permitReason = valueReason;
    // print("PERMIT REASON $_permitReason");
    try {
      Map<String, dynamic> response = await _api.fetchPermitAvailable(
        dateFrom: _sendDateFromC.text,
        dateTo: _sendDateToC.text,
        reasonId: valueReason,
        permitTypeId: _permitType!.id,
      );
      _totalAvailable = response['total'];

      // print("TOTAL AVAILABLE $totalAvailable");
      _permitAvailableC.text = _totalAvailable.toString();
      notifyListeners();
      return true;
    } catch (e) {
      _message = 'Something wrong Fetching Permit Available';
      notifyListeners();
      return false;
    }
  }

  // Future<void> fetchCutOff() async {
  //   _loading = true;
  //   var response = await _apiDashboard.fetchCutOff();
  //   String respStart = response['start'];
  //   String tanggal = respStart.split("-").last;
  //   _dateStart = int.parse(tanggal);
  //   setState(() {
  //     _loading = false;
  //   });
  // }

  void openCalendarFrom(BuildContext context) async {
    final lastDate = DateTime(_now.year + 1, _now.month, _now.day);
    late DateTime firstDate;
    // if (_now.isBefore(DateTime(_now.year, _now.month, _dateStart))) {
    // } else {
    //   firstDate = DateTime(_now.year, _now.month, _dateStart);
    // }

    // if (_now.month == 1) {
    //   firstDate = DateTime(_now.year - 1, 12, 1);
    // } else {
    firstDate = DateTime(_now.year, _now.month - 1, 1, 12);
    // }

    final selected = await showDatePicker(context: context, initialDate: _now, firstDate: firstDate, lastDate: lastDate);

    if (selected != null) {
      _dateFromC.text = DateFormat("dd MMMM yyyy").format(selected);
      _sendDateFromC.text = formatDateAttendance(selected);

      _dateToC.clear();
      _sendDateToC.clear();

      if (_sendDateFromC.text.isNotEmpty && _sendDateToC.text.isNotEmpty) {
        _readOnlyPermitType = true;
      }

      notifyListeners();
    }
  }

  void openCalendarTo(BuildContext context) async {
    final lastDate = DateTime(_now.year + 1, _now.month, _now.day);
    late DateTime firstDate;
    // if (_now.isBefore(DateTime(_now.year, _now.month, _dateStart))) {
    // } else {
    //   firstDate = DateTime(_now.year, _now.month, _dateStart);
    // }

    // if (_now.month == 1) {
    //   firstDate = DateTime(_now.year - 1, 12, 1);
    // } else {
    firstDate = DateTime(_now.year, _now.month - 1, 1, 12);
    // }

    if (_sendDateFromC.text.isNotEmpty) {
      firstDate = DateFormat("yyyy-MM-dd").parse(_sendDateFromC.text);
    }

    final selected = await showDatePicker(context: context, initialDate: _now, firstDate: firstDate, lastDate: lastDate);

    if (selected != null) {
      _dateToC.text = DateFormat("dd MMMM yyyy").format(selected);
      _sendDateToC.text = formatDateAttendance(selected);
      notifyListeners();
    }
  }

  Future<void> openGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
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
        _info = "File too large, max 1 MB";
        notifyListeners();
        return;
      }

      // _selectImage = selectedImage;
      notifyListeners();

      return;
    } else {
      if (!context.mounted) return;
      return showFailSnackbar(context, "Failed to load data. check your connection or restart the app");
    }
  }

  Future<void> openCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      final XFile? selectedImage = await picker.pickImage(source: ImageSource.camera, imageQuality: 25);

      if (selectedImage == null) return;
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
      if (!context.mounted) return;
      // debugPrint("${response.exception}");
      return showFailSnackbar(context, "Failed to load data. check your storage");
    }
  }

  Future<dynamic> addPermit() async {
    final image = _selectImage == null ? null : File(_selectImage!.path);

    Map<String, dynamic> response = await _api.addPermit(
      _permitType!.id,
      _permitReason!,
      _sendDateFromC.text,
      _sendDateToC.text,
      _totalAvailable.toString(),
      _remarksC.text,
      image,
    );
    try {
      ResponsePermit responsePermit = ResponsePermit.fromJson(response);
      if (responsePermit.theme == "success") {
        // await fetchPermit(context);
        // _listPermitReason.clear();
        notifyListeners();
        return responsePermit;
      } else {
        return responsePermit;
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

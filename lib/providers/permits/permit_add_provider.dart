import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/response/permit_type_model.dart';
import 'package:easy_hris/data/models/response/reason_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../constant/constant.dart';
import '../../data/models/permit.dart';
import '../../data/models/permit_reason.dart';
import '../../data/models/permit_type.dart';
import '../../data/network/api/api_permit.dart';
import '../../data/services/images_services.dart';
import '../../injection.dart';
import '../../ui/util/utils.dart';

class PermitAddProvider extends ChangeNotifier {
  final ApiPermit _api = ApiPermit();
  final _imagesServices = ImagesServices();
  final _prefs = sl<SharedPreferences>();

  ResultStatus _resultStatus = ResultStatus.init;
  String _title = '';
  String _message = '';
  final _timeNow = TimeOfDay.now();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _permitDateController = TextEditingController();
  final TextEditingController _permitTypeController = TextEditingController();
  final TextEditingController _reasonNameController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final TextEditingController _attachmentController = TextEditingController();
  File? _attachment;

  PermitTypeModel? _permitTypeModel;
  ReasonModel? _reasonModel;

  List<PermitTypeModel> _listPermitType = [];
  List<ReasonModel> _listReasonModel = [];

  // variable untuk di send
  String _permitDateSend = '';

  String _info = "File max 1 MB";

  final DateTime _now = DateTime.now().toLocal();

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController get permitDateController => _permitDateController;
  TextEditingController get permitTypeController => _permitTypeController;
  TextEditingController get reasonNameController => _reasonNameController;
  TextEditingController get startTimeController => _startTimeController;
  TextEditingController get endTimeController => _endTimeController;
  TextEditingController get noteController => _noteController;
  TextEditingController get attachmentController => _attachmentController;

  PermitTypeModel? get permitTypeModel => _permitTypeModel;
  ReasonModel? get reasonModel => _reasonModel;
  File? get attachment => _attachment;

  List<PermitTypeModel> get listPermitType => _listPermitType;
  List<ReasonModel> get listReason => _listReasonModel;

  ResultStatus get resultStatus => _resultStatus;

  String get title => _title;
  String get message => _message;

  PermitAddProvider() {
    _fetchPermitType();
  }

  Future<dynamic> _fetchPermitType() async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      final result = await _api.fetchPermitTypes();

      if (result.theme == 'success') {
        _listPermitType = result.result!;
        if (_listPermitType.isEmpty) {
          _resultStatus = ResultStatus.noData;
          _message = "Master Permit Type is Empty";
          notifyListeners();
        } else {
          _resultStatus = ResultStatus.hasData;
          notifyListeners();
        }
      } else {
        _resultStatus = ResultStatus.error;
        _message = result.message!;
        notifyListeners();
      }
    } catch (e) {
      _message = e.toString();
      _resultStatus = ResultStatus.error;
      notifyListeners();
    }
  }

  Future<bool> fetchPermitReason(PermitTypeModel permitType) async {
    try {
      final result = await _api.fetchReason(permitTypeId: permitType.id!);

      if (result.theme == 'success') {
        _listReasonModel = result.result!;
        if (_listReasonModel.isEmpty) {
          _title = "Empty";
          _message = "Master Reason Name is Empty";
          return false;
        } else {
          _resultStatus = ResultStatus.hasData;
          return true;
        }
      } else {
        _title = result.title!;
        _message = result.message!;
        return false;
      }
    } catch (e) {
      print("Error permit reason $e");
      _message = e.toString();
      return false;
    }
  }

  void onChangePicker(DateTime? pickDate) {
    _permitDateSend = DateFormat('yyyy-MM-dd').format(pickDate!);
    _permitDateController.text = DateFormat('dd MMMM yyyy').format(pickDate);
    notifyListeners();
  }

  void onChangePermitType(PermitTypeModel item) {
    _permitTypeModel = item;
    _permitTypeController.text = item.name!;
    _reasonNameController.clear();
    _reasonModel = null;

    if (_permitTypeModel?.meal == '1') {
      _startTimeController.text = '08:00:00';
      _endTimeController.text = '17:00:00';
    }

    notifyListeners();
  }

  void onChangeReason(ReasonModel item) {
    _reasonModel = item;
    _reasonNameController.text = item.name!;
    notifyListeners();
  }

  void onChangeAttachment(File file, String base64) {
    final now = DateTime.now();
    final format = DateFormat('yyyy_MM_dd_HHmmss').format(now);
    _attachment = file;
    _attachmentController.text = "attachment_$format";
    notifyListeners();
  }

  Future<bool> addPermit() async {
    final image = _attachment == null ? null : File(_attachment!.path);
    final number = _prefs.getString(ConstantSharedPref.numberUser);

    try {
      final result = await _api.addPermit(
        number: number ?? '',
        permitDate: _permitDateSend,
        permitTypeId: _permitTypeModel?.id.toString() ?? '',
        reasonId: _reasonModel?.id.toString() ?? '',
        start: _startTimeController.text,
        end: _endTimeController.text,
        note: _noteController.text,
        attachment: image,
      );

      _title = result.title!;
      _message = result.message!;
      notifyListeners();

      if (result.theme == 'success') {
        return true;
      } else {
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
    } catch (e, trace) {
      print("error $e");
      print("error $trace");
      _message = errMessage;
      notifyListeners();
      return false;
    }
  }

  void openChangeStart(TimeOfDay selected) async {
    final h = selected.hour.toString().padLeft(2, '0');
    final m = selected.minute.toString().padLeft(2, '0');

    print("Selected $selected");

    _startTimeController.text = "$h:$m:00";
    notifyListeners();
  }

  void openChangeEnd(TimeOfDay selected) async {
    final h = selected.hour.toString().padLeft(2, '0');
    final m = selected.minute.toString().padLeft(2, '0');

    print("Selected $selected");

    _endTimeController.text = "$h:$m:00";
    notifyListeners();
  }

  // void onChangeEnd(TimeOfDay selected) async {
  //   TimeOfDay? selected = await showTimePicker(context: context, initialTime: _timeNow);
  //
  //   if (selected != null) {
  //     if (!context.mounted) return;
  //     final h = selected.hour.toString().padLeft(2, '0');
  //     final m = selected.minute.toString().padLeft(2, '0');
  //
  //     print("Selected $selected");
  //
  //     _startTimeController.text = "$h:$m";
  //     notifyListeners();
  //   }
  // }
}

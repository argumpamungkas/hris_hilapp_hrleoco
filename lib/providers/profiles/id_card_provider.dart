import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/response/position_model.dart';
import 'package:easy_hris/data/network/api/api_employee.dart';
import 'package:easy_hris/data/services/url_services.dart';
import 'package:flutter/material.dart';

import '../../data/models/response/employee_model.dart';
import '../../data/models/response/id_name_model.dart';
import '../../data/models/response/marital_model.dart';
import '../../data/models/response/religion_model.dart';
import '../../injection.dart';

class IdCardProvider extends ChangeNotifier {
  final ApiEmployee _api = ApiEmployee();
  final _prefs = sl<SharedPreferences>();
  final _urlService = sl<UrlServices>();

  ResultStatus _resultStatus = ResultStatus.init;
  Employee? _employee;
  PositionModel? _employeePosition;
  String _barcodeString = '';
  String _message = "";
  String _baseUrl = '';

  /// FROM MASTER
  IdNameModel? _selectedGender;
  IdNameModel? _selectedBlood;
  ReligionModel? _selectedReligion;
  MaritalModel? _selectedMarital;

  String get baseUrl => _baseUrl;
  Employee? get employee => _employee;
  PositionModel? get employeePosition => _employeePosition;
  ResultStatus get resultStatus => _resultStatus;
  String get barcodeString => _barcodeString;
  String get message => _message;

  IdNameModel? get selectedGender => _selectedGender;
  IdNameModel? get selectedBlood => _selectedBlood;
  ReligionModel? get selectedReligion => _selectedReligion;
  MaritalModel? get selectedMarital => _selectedMarital;

  IdCardProvider() {
    fetchPersonalData();
  }

  Future<void> getUrl() async {
    final urlModel = await _urlService.getUrlModel();
    _baseUrl = urlModel!.link!;
    return;
  }

  Future<void> fetchPersonalData() async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      final number = _prefs.getString(ConstantSharedPref.numberUser);
      final result = await _api.fetchEmployeeUser(number ?? "");

      if (result.theme == "success") {
        _employee = result.result?.employee;
        _employeePosition = result.result?.position;
        _barcodeString = 'NIK : ${_employee?.number}, Name : ${{_employee?.name}}';
        await getUrl();
        await assign(_employee!);

        _resultStatus = ResultStatus.hasData;
      } else {
        _resultStatus = ResultStatus.noData;
        _message = "Data not found";
      }
      notifyListeners();
    } catch (e, trace) {
      _message = e.toString();
      _resultStatus = ResultStatus.error;
      notifyListeners();
    }
  }

  Future<void> assign(Employee employee) async {
    if (employee.imageProfile != null && employee.imageProfile != "" && employee.imageProfile != '-') {
      _employee?.imageProfile = "$_baseUrl/${Constant.urlProfileImage}/${employee.imageProfile}";

      // _fileImageProfile = await _api.urlToFile(
      //   "$_baseUrl/${Constant.urlProfileImage}/${employee.imageProfile}",
      //   fileName: "profile_${format}_${employee.imageProfile}",
      // );
    }
  }
}

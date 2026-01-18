import 'dart:io';

import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/network/api/api_employee.dart';
import 'package:easy_hris/data/services/url_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/models/response/employee_model.dart';
import '../data/models/response/id_name_model.dart';
import '../data/models/response/marital_model.dart';
import '../data/models/response/religion_model.dart';

class PersonalDataProvider extends ChangeNotifier {
  final ApiEmployee _api = ApiEmployee();
  final UrlServices _urlServices = UrlServices();

  ResultStatus _resultStatus = ResultStatus.init;
  Employee? _employee;
  String _message = "";
  String _baseUrl = '';

  List<IdNameModel> _listGender = [];
  List<IdNameModel> _listBlood = [];
  List<ReligionModel> _listReligion = [];
  List<MaritalModel> _listMarital = [];

  /// FILE
  File? _fileImageProfile;
  File? _fileNationalId;
  File? _fileFamilyCard;
  File? _fileTaxNoNPWP;

  /// FROM MASTER
  IdNameModel? _selectedGender;
  IdNameModel? _selectedBlood;
  ReligionModel? _selectedReligion;
  MaritalModel? _selectedMarital;

  String get baseUrl => _baseUrl;
  Employee? get employee => _employee;
  ResultStatus get resultStatus => _resultStatus;
  String get message => _message;

  File? get fileNationalIdFIle => _fileNationalId;
  File? get fileFamilyCard => _fileFamilyCard;
  File? get fileTaxNoNPWP => _fileTaxNoNPWP;
  File? get filePhotoProfile => _fileImageProfile;

  IdNameModel? get selectedGender => _selectedGender;
  IdNameModel? get selectedBlood => _selectedBlood;
  ReligionModel? get selectedReligion => _selectedReligion;
  MaritalModel? get selectedMarital => _selectedMarital;

  PersonalDataProvider() {
    fetchPersonalData();
  }

  Future<void> getUrl() async {
    final urlModel = await _urlServices.getUrlModel();
    _baseUrl = urlModel!.link!;
    return;
  }

  Future<void> fetchPersonalData() async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    try {
      await Future.wait([fetchGender(), fetchBlood(), fetchReligion(), fetchMarital()]);
      final number = prefs.getString(ConstantSharedPref.numberUser);
      final result = await _api.fetchEmployee(number ?? "");

      if (result.theme == "success") {
        _employee = result.result?.employee;
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
    final now = DateTime.now();
    final format = DateFormat('yyyy_MM_dd').format(now);

    print("assign");

    /// image
    if (employee.imageId != null && employee.imageId != "" && employee.imageId != '-') {
      _fileNationalId = await _api.urlToFile(
        "$_baseUrl/${Constant.urlProfileKtp}/${_employee?.imageId}",
        fileName: "ktp_${format}_${_employee?.imageId}",
      );
    }

    if (employee.imageKk != null && employee.imageKk != "" && employee.imageKk != '-') {
      _fileFamilyCard = await _api.urlToFile("$_baseUrl/${Constant.urlProfileKk}/${employee.imageKk}", fileName: "kk_${format}_${employee.imageKk}");
    }

    if (employee.imageNpwp != null && employee.imageNpwp != "" && employee.imageNpwp != '-') {
      _fileTaxNoNPWP = await _api.urlToFile(
        "$_baseUrl/${Constant.urlProfileNpwp}/${employee.imageNpwp}",
        fileName: "taxno_${format}_${employee.imageNpwp}",
      );
    }

    if (employee.imageProfile != null && employee.imageProfile != "" && employee.imageProfile != '-') {
      _fileImageProfile = await _api.urlToFile(
        "$_baseUrl/${Constant.urlProfileImage}/${employee.imageProfile}",
        fileName: "profile_${format}_${employee.imageProfile}",
      );
    }

    /// GENDER
    if (employee.gender!.isNotEmpty) {
      for (var item in _listGender) {
        if (employee.gender?.toUpperCase() == item.id.toUpperCase()) {
          _selectedGender = item;
          break;
        }
      }
    }

    /// BLOOD
    if (employee.blood!.isNotEmpty) {
      for (var item in _listBlood) {
        if (employee.blood?.toUpperCase() == item.id.toUpperCase()) {
          _selectedBlood = item;
          break;
        }
      }
    }

    /// RELIGION
    if (employee.religionId!.isNotEmpty) {
      for (var item in _listReligion) {
        if (employee.religionId?.toUpperCase() == item.id?.toUpperCase()) {
          _selectedReligion = item;
          break;
        }
      }
    }

    /// MARITAL
    if (employee.maritalId!.isNotEmpty) {
      for (var item in _listMarital) {
        if (employee.maritalId?.toUpperCase() == item.id?.toUpperCase()) {
          _selectedMarital = item;
          break;
        }
      }
    }
  }

  Future<void> fetchGender() async {
    try {
      final result = await _api.fetchMaster("gender");

      if (result.theme == "success") {
        _listGender = result.result!;
      } else {
        _listGender = [];
      }

      notifyListeners();
    } catch (e) {
      print("error");
      notifyListeners();
    }
  }

  Future<void> fetchBlood() async {
    try {
      final result = await _api.fetchMaster("blood");

      if (result.theme == "success") {
        _listBlood = result.result!;
      } else {
        _listBlood = [];
      }

      notifyListeners();
    } catch (e) {
      print("error");
      notifyListeners();
    }
  }

  Future<void> fetchReligion() async {
    try {
      final result = await _api.fetchReligion("religions");

      if (result.theme == "success") {
        _listReligion = result.result!;
      } else {
        _listReligion = [];
      }

      notifyListeners();
    } catch (e) {
      print("error");
      notifyListeners();
    }
  }

  Future<void> fetchMarital() async {
    try {
      final result = await _api.fetchMarital("maritals");

      if (result.theme == "success") {
        _listMarital = result.result!;
      } else {
        _listMarital = [];
      }

      notifyListeners();
    } catch (e) {
      print("error");
      notifyListeners();
    }
  }
}

import 'dart:io';

import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/id_name_model.dart';
import 'package:easy_hris/data/models/marital_model.dart';
import 'package:easy_hris/data/models/religion_model.dart';
import 'package:easy_hris/data/models/request/personal_data_update_request.dart';
import 'package:easy_hris/data/network/api/api_employee.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/employee_response_model.dart';

class PersonalEmployeeProvider extends ChangeNotifier {
  final ApiEmployee _api = ApiEmployee();
  ResultStatus _resultStatus = ResultStatus.init;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _domicileController = TextEditingController();
  final TextEditingController _placeOfBirthController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _maritalStatusController = TextEditingController();
  final TextEditingController _nationalIdNoController = TextEditingController();
  final TextEditingController _familyCardController = TextEditingController();

  /// CONTACT
  final TextEditingController _taxNoController = TextEditingController();
  final TextEditingController _telephoneNoController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _emergencyNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberOfFamilyController = TextEditingController();
  final TextEditingController _bpjsController = TextEditingController();
  final TextEditingController _bpjsDateController = TextEditingController();
  final TextEditingController _jknController = TextEditingController();
  final TextEditingController _jknDateController = TextEditingController();
  final TextEditingController _drivingLicenseController = TextEditingController();
  final TextEditingController _drivingLicenseDateController = TextEditingController();
  final TextEditingController _stnkNoController = TextEditingController();
  final TextEditingController _stnkNoDateController = TextEditingController();

  /// FILE
  final TextEditingController _fileNationalIdBase64 = TextEditingController();
  final TextEditingController _fileNationalIdName = TextEditingController();
  final TextEditingController _fileFamilyCardBase64 = TextEditingController();
  final TextEditingController _fileFamilyCardName = TextEditingController();
  final TextEditingController _fileTaxNoNPWPBase64 = TextEditingController();
  final TextEditingController _fileTaxNoNPWPName = TextEditingController();
  final TextEditingController _filePhotoProfileBase64 = TextEditingController();
  final TextEditingController _filePhotoProfileName = TextEditingController();

  String _imageProfileFromDataExist = '';
  String _imageKKFromDataExist = '';
  String _imageKTPFromDataExist = '';
  String _imageNPWPFromDataExist = '';

  File? _fileImageProfile;
  File? _fileNationalId;
  File? _fileFamilyCard;
  File? _fileTaxNoNPWP;

  /// IMG

  /// LIST DATA
  List<IdNameModel> _listGender = [];
  List<IdNameModel> _listBlood = [];
  List<ReligionModel> _listReligion = [];
  List<MaritalModel> _listMarital = [];

  /// SELECTED
  IdNameModel? _selectedGender;
  IdNameModel? _selectedBlood;
  ReligionModel? _selectedReligion;
  MaritalModel? _selectedMarital;

  ///
  String _title = '';
  String _message = '';

  ResultStatus get resultStatus => _resultStatus;
  GlobalKey<FormState> get key => _key;
  TextEditingController get addressController => _addressController;
  TextEditingController get domicileController => _domicileController;
  TextEditingController get placeOfBirthController => _placeOfBirthController;
  TextEditingController get birthDateController => _birthDateController;
  TextEditingController get genderController => _genderController;
  TextEditingController get bloodTypeController => _bloodTypeController;
  TextEditingController get religionController => _religionController;
  TextEditingController get maritalStatusController => _maritalStatusController;
  TextEditingController get nationalIdNoController => _nationalIdNoController;
  TextEditingController get familyCardController => _familyCardController;

  ///CONTACT
  TextEditingController get taxNoController => _taxNoController;
  TextEditingController get telephoneNoController => _telephoneNoController;
  TextEditingController get phoneNoController => _phoneNoController;
  TextEditingController get emergencyNoController => _emergencyNoController;
  TextEditingController get emailController => _emailController;
  TextEditingController get numberOfFamilyController => _numberOfFamilyController;
  TextEditingController get bpjsController => _bpjsController;
  TextEditingController get bpjsDateController => _bpjsDateController;
  TextEditingController get jknController => _jknController;
  TextEditingController get jknDateController => _jknDateController;
  TextEditingController get drivingLicenseController => _drivingLicenseController;
  TextEditingController get drivingLicenseDateController => _drivingLicenseDateController;
  TextEditingController get stnkNoController => _stnkNoController;
  TextEditingController get stnkNoDateController => _stnkNoDateController;

  /// FILE
  TextEditingController get fileNationalIdBase64 => _fileNationalIdBase64;
  TextEditingController get fileFamilyCardBase64 => _fileFamilyCardBase64;
  TextEditingController get fileTaxNoNPWPBase64 => _fileTaxNoNPWPBase64;
  TextEditingController get filePhotoProfileBase64 => _filePhotoProfileBase64;

  TextEditingController get fileNationalIdName => _fileNationalIdName;
  TextEditingController get fileFamilyCardName => _fileFamilyCardName;
  TextEditingController get fileTaxNoNPWPName => _fileTaxNoNPWPName;
  TextEditingController get filePhotoProfileName => _filePhotoProfileName;

  File? get fileNationalIdFIle => _fileNationalId;
  File? get fileFamilyCard => _fileFamilyCard;
  File? get fileTaxNoNPWP => _fileTaxNoNPWP;
  File? get filePhotoProfile => _fileImageProfile;

  /// FILE EXIST
  String get imageProfileDataExist => _imageProfileFromDataExist;
  String get imageKKFromDataExist => _imageKKFromDataExist;
  String get imageKTPFromDataExist => _imageKTPFromDataExist;
  String get imageNPWPFromDataExist => _imageNPWPFromDataExist;

  ///LIST
  List<IdNameModel> get listGender => _listGender;
  List<IdNameModel> get listBlood => _listBlood;
  List<ReligionModel> get listReligion => _listReligion;
  List<MaritalModel> get listMarital => _listMarital;

  String get title => _title;
  String get message => _message;

  String _number = '';

  PersonalEmployeeProvider(EmployeeResponseModel employee) {
    init(employee);
  }

  void onChangeGender(IdNameModel value) {
    _genderController.text = value.name;
    _selectedGender = value;
    notifyListeners();
  }

  void onChangeBloodType(IdNameModel value) {
    _bloodTypeController.text = value.name;
    _selectedBlood = value;
    notifyListeners();
  }

  void onChangeReligion(ReligionModel value) {
    _religionController.text = value.name!;
    _selectedReligion = value;
    notifyListeners();
  }

  void onChangeMarital(MaritalModel value) {
    _maritalStatusController.text = value.name!;
    _selectedMarital = value;
    notifyListeners();
  }

  void onChangePicker(DateTime? pickDate) {
    _birthDateController.text = DateFormat('yyyy-MM-dd').format(pickDate!);
    notifyListeners();
  }

  void onChangePickerDriver(DateTime? pickDate) {
    _drivingLicenseDateController.text = DateFormat('yyyy-MM-dd').format(pickDate!);
    notifyListeners();
  }

  void onChangePickerStnk(DateTime? pickDate) {
    _stnkNoDateController.text = DateFormat('yyyy-MM-dd').format(pickDate!);
    notifyListeners();
  }

  void onChangeFileNationalId(File file, String base64) {
    final now = DateTime.now();
    final format = DateFormat('yyyy_MM_dd').format(now);
    _fileNationalId = file;
    _fileNationalIdBase64.text = base64;
    _fileNationalIdName.text = "natId_${_number}_$format";
    notifyListeners();
  }

  void onChangeFileFamilyCard(File file, String base64) {
    final now = DateTime.now();
    final format = DateFormat('yyyy_MM_dd').format(now);
    _fileFamilyCard = file;
    _fileFamilyCardBase64.text = base64;
    _fileFamilyCardName.text = "kk_${_number}_$format";
    notifyListeners();
  }

  void onChangeFileTaxNPWP(File file, String base64) {
    final now = DateTime.now();
    final format = DateFormat('yyyy_MM_dd').format(now);
    _fileTaxNoNPWP = file;
    _fileTaxNoNPWPBase64.text = base64;
    _fileTaxNoNPWPName.text = "tax_${_number}_$format";
    notifyListeners();
  }

  void onChangeFileImgProfile(File file, String base64) {
    final now = DateTime.now();
    final format = DateFormat('yyyy_MM_dd').format(now);
    _fileImageProfile = file;
    _filePhotoProfileBase64.text = base64;
    _filePhotoProfileName.text = "profile_${_number}_$format";
    notifyListeners();
  }

  Future<void> init(EmployeeResponseModel employee) async {
    _resultStatus = ResultStatus.loading;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      _number = prefs.getString(ConstantSharedPref.numberUser)!;

      await Future.wait([fetchGender(), fetchBlood(), fetchReligion(), fetchMarital()]);
      await assignData(employee);

      _resultStatus = ResultStatus.hasData;
      notifyListeners();
    } catch (e) {
      _title = "Failed";
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<void> assignData(EmployeeResponseModel employee) async {
    _addressController.text = employee.employee?.address ?? "";
    _domicileController.text = employee.employee?.domicile ?? "";
    _placeOfBirthController.text = employee.employee?.placeBirth ?? "";
    _birthDateController.text = employee.employee?.birthday ?? "";
    _nationalIdNoController.text = employee.employee?.nationalId ?? "";
    _familyCardController.text = employee.employee?.kkNo ?? "";

    _taxNoController.text = employee.employee?.taxId ?? "";
    _telephoneNoController.text = employee.employee?.telphone ?? "";
    _phoneNoController.text = employee.employee?.mobilePhone ?? "";
    _emergencyNoController.text = employee.employee?.emergencyNo ?? "";
    _emailController.text = employee.employee?.email ?? "";
    _numberOfFamilyController.text = employee.employee?.jknFamily ?? "";
    _bpjsController.text = employee.employee?.jamsostek ?? "";
    _bpjsDateController.text = employee.employee?.jamsostekDate ?? "";
    _jknController.text = employee.employee?.jkn ?? "";
    _jknDateController.text = employee.employee?.jknDate ?? "";
    _drivingLicenseController.text = employee.employee?.drivingNo ?? "";
    _drivingLicenseDateController.text = employee.employee?.drivingDate ?? "";
    _stnkNoController.text = employee.employee?.stnkNo ?? "";
    _stnkNoDateController.text = employee.employee?.stnkDate ?? "";

    final now = DateTime.now();
    final format = DateFormat('yyyy_MM_dd').format(now);

    /// image
    if (employee.employee?.imageId != null && employee.employee?.imageId != "" && employee.employee?.imageId != '-') {
      _imageKTPFromDataExist = employee.employee?.imageId ?? "";
      _fileNationalIdName.text = employee.employee?.imageId ?? "";
      if (_imageKTPFromDataExist.isNotEmpty) {
        _fileNationalId = await _api.urlToFile(
          "${Constant.baseUrl}/${Constant.urlProfileKtp}/${_imageKTPFromDataExist}",
          fileName: "ktp_${format}_${_fileNationalIdName.text}",
        );
      }
    }

    if (employee.employee?.imageKk != null && employee.employee?.imageKk != "" && employee.employee?.imageKk != '-') {
      _imageKKFromDataExist = employee.employee?.imageKk ?? "";
      _fileFamilyCardName.text = employee.employee?.imageKk ?? "";
      if (_imageKKFromDataExist.isNotEmpty) {
        _fileFamilyCard = await _api.urlToFile(
          "${Constant.baseUrl}/${Constant.urlProfileKk}/${_imageKKFromDataExist}",
          fileName: "kk_${format}_${_fileFamilyCardName.text}",
        );
      }
    }

    if (employee.employee?.imageNpwp != null && employee.employee?.imageNpwp != "" && employee.employee?.imageNpwp != '-') {
      _imageNPWPFromDataExist = employee.employee?.imageNpwp ?? "";
      _fileTaxNoNPWPName.text = employee.employee?.imageNpwp ?? "";
      if (_imageNPWPFromDataExist.isNotEmpty) {
        _fileTaxNoNPWP = await _api.urlToFile(
          "${Constant.baseUrl}/${Constant.urlProfileNpwp}/${_imageNPWPFromDataExist}",
          fileName: "taxno_${format}_${_fileTaxNoNPWPName.text}",
        );
      }
    }

    if (employee.employee?.imageProfile != null && employee.employee?.imageProfile != "" && employee.employee?.imageProfile != '-') {
      _imageProfileFromDataExist = employee.employee?.imageProfile ?? "";
      _filePhotoProfileName.text = employee.employee?.imageProfile ?? "";
      if (_imageProfileFromDataExist.isNotEmpty) {
        _fileImageProfile = await _api.urlToFile(
          "${Constant.baseUrl}/${Constant.urlProfileImage}/${_imageProfileFromDataExist}",
          fileName: "profile_${format}_${_filePhotoProfileName.text}",
        );
      }
    }

    /// GENDER
    for (var item in _listGender) {
      if (employee.employee?.gender?.toUpperCase() == item.id.toUpperCase()) {
        _genderController.text = item.name;

        _selectedGender = item;
        break;
      }
    }

    /// BLOOD
    for (var item in _listBlood) {
      if (employee.employee?.blood?.toUpperCase() == item.id.toUpperCase()) {
        _bloodTypeController.text = item.name;

        _selectedBlood = item;
        break;
      }
    }

    /// RELIGION
    for (var item in _listReligion) {
      if (employee.employee?.religionId?.toUpperCase() == item.id?.toUpperCase()) {
        _religionController.text = item.name!;

        _selectedReligion = item;
        break;
      }
    }

    /// MARITAL
    for (var item in _listMarital) {
      if (employee.employee?.maritalId?.toUpperCase() == item.id?.toUpperCase()) {
        _maritalStatusController.text = item.name!;

        _selectedMarital = item;
        break;
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

  Future<bool> updatePersonalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final number = prefs.getString(ConstantSharedPref.numberUser);

    final request = PersonalDataUpdateRequest(
      number: number ?? "",
      address: _addressController.text,
      domicile: _domicileController.text,
      placeBirth: _placeOfBirthController.text,
      birthday: _birthDateController.text,
      gender: _selectedGender!.id,
      blood: _selectedBlood!.id,
      religionId: _selectedReligion!.id!,
      maritalId: _selectedMarital!.id!,
      nationalId: _nationalIdNoController.text,
      taxId: _taxNoController.text,
      jknFamily: _numberOfFamilyController.text,
      telphone: _telephoneNoController.text,
      mobilePhone: _phoneNoController.text,
      emergencyNo: _emergencyNoController.text,
      email: _emailController.text,
      drivingNo: _drivingLicenseController.text,
      drivingDate: _drivingLicenseDateController.text,
      stnkNo: _stnkNoController.text,
      stnkDate: _stnkNoDateController.text,
      kkNo: _familyCardController.text,
    );

    try {
      final result = await _api.updatePersonalData(
        requestUser: request,
        fileNationalID: _fileNationalId!,
        fileKK: _fileFamilyCard!,
        fileTax: _fileTaxNoNPWP!,
        fileImageProfile: _fileImageProfile!,
      );

      if (result.theme == 'success') {
        _title = result.title!;
        _message = result.message!;
        return true;
      } else {
        _title = result.title!;
        _message = result.message!;
        return false;
      }
    } catch (e, trcae) {
      print("trace $trcae");
      print("trace $e");
      _title = "Failed";
      _message = e.toString();
      notifyListeners();
      return false;
    }
  }
}

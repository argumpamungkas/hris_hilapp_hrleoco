import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_hris/data/models/response/api_response.dart';
import 'package:easy_hris/data/models/response/employee_response_model.dart';
import 'package:easy_hris/data/models/response/id_name_model.dart';
import 'package:easy_hris/data/models/response/marital_model.dart';
import 'package:easy_hris/data/models/response/religion_model.dart';
import 'package:easy_hris/data/models/request/career_request.dart';
import 'package:easy_hris/data/models/request/education_request.dart';
import 'package:easy_hris/data/models/request/experience_request.dart';
import 'package:easy_hris/data/models/request/family_request.dart';
import 'package:easy_hris/data/models/request/personal_data_update_request.dart';
import 'package:easy_hris/data/models/request/training_request.dart';
import 'package:easy_hris/data/services/url_services.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../../constant/constant.dart';
import 'package:http/http.dart' as http;

import '../../../injection.dart';
import '../../models/response/employee_model.dart';

class ApiEmployee {
  final _urlService = sl<UrlServices>();

  Future<ApiResponse<List<IdNameModel>>> fetchMaster(String source) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/master/reads?source=$source");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      // print("result => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => IdNameModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<List<ReligionModel>>> fetchReligion(String source) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/master/reads?source=$source");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      // print("result => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => ReligionModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<List<MaritalModel>>> fetchMarital(String source) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/master/reads?source=$source");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      // print("result => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => MaritalModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<EmployeeModel>> fetchEmployee(String numberUser) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/employees/reads?number=$numberUser");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      // print("result => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => EmployeeModel.fromJson(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<EmployeeResponseModel>> fetchEmployeeUser(String numberUser) async {
    // print("call");
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/employees/reads?number=$numberUser");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      // print("result fetchEmployeeuser => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => EmployeeResponseModel.fromJson(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse> updatePersonalData({
    required PersonalDataUpdateRequest requestUser,
    required File fileNationalID,
    required File fileKK,
    required File fileTax,
    required File fileImageProfile,
  }) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/employees/updateData");

    try {
      final request = http.MultipartRequest("POST", url);

      final req = requestUser.toJson();

      request.fields.addAll(req);

      // print("ktp => ${fileNationalID.path}");
      // print("kk => ${fileKK.path}");
      // print("tax => ${fileTax.path}");
      // print("pr => ${fileImageProfile.path}");

      request.files.add(await http.MultipartFile.fromPath('image_id', fileNationalID.path));
      request.files.add(await http.MultipartFile.fromPath('image_kk', fileKK.path));
      request.files.add(await http.MultipartFile.fromPath('image_npwp', fileTax.path));
      request.files.add(await http.MultipartFile.fromPath('image_profile', fileImageProfile.path));

      // var response = await http.post(url, body: request.toJson());
      //
      // print("response $response");
      // print("response ${response.body}");
      //
      // Map<String, dynamic> result = jsonDecode(response.body);
      //
      // debugPrint("result add educ => $result");

      final response = await request.send();

      // print("response $response");
      // print("response ${response.reasonPhrase}");
      // baca stream jadi string
      final responseBody = await response.stream.bytesToString();

      // print("status code => ${response.statusCode}");
      // print("body => $responseBody");

      // decode JSON
      final Map<String, dynamic> result = jsonDecode(responseBody);

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => null);
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      print("debugPrint $e");
      print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse> addFamily(FamilyRequest request) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/employees/createFamily");

    try {
      var response = await http.post(url, body: request.toJson());

      Map<String, dynamic> result = jsonDecode(response.body);

      // debugPrint("result addFamily => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => null);
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("debugPrint $e");
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse> deleteDataEmployee(String id, String number, String endPoint) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/employees/$endPoint");

    try {
      var response = await http.post(url, body: {"id": id, "number": number});

      Map<String, dynamic> result = jsonDecode(response.body);

      // debugPrint("result addFamily => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => null);
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("debugPrint $e");
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse> addEducation(EducationRequest request) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/employees/createEducation");

    try {
      var response = await http.post(url, body: request.toJson());

      Map<String, dynamic> result = jsonDecode(response.body);

      // debugPrint("result add educ => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => null);
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("debugPrint $e");
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse> addExperience(ExperienceRequest request) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/employees/createExperience");

    try {
      var response = await http.post(url, body: request.toJson());

      Map<String, dynamic> result = jsonDecode(response.body);

      // debugPrint("result add educ => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => null);
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("debugPrint $e");
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse> addTraining(TrainingRequest request) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/employees/createTraining");

    try {
      var response = await http.post(url, body: request.toJson());

      Map<String, dynamic> result = jsonDecode(response.body);

      // debugPrint("result add educ => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => null);
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("debugPrint $e");
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse> addCareer(CareerRequest request) async {
    final baseUrl = await _urlService.getUrlModel();

    Uri url = Uri.parse("${baseUrl!.link}/api/employees/createCarrer");

    try {
      var response = await http.post(url, body: request.toJson());

      // print("response $response");
      // print("response ${response.body}");

      Map<String, dynamic> result = jsonDecode(response.body);

      // debugPrint("result add educ => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => null);
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      // print("debugPrint $e");
      // print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<File?> urlToFile(String imageUrl, {String? fileName}) async {
    // print("IMAGE URL => $imageUrl");

    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode != 200) {
        throw Exception('Gagal download gambar');
      }

      Uint8List bytes = response.bodyBytes;

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${fileName ?? 'image_$fileName.png'}');

      await file.writeAsBytes(bytes);

      return file;
    } catch (e) {
      // print("error get foto $e");
      return null;
    }
  }
}

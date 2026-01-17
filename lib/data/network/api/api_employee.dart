import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_hris/data/models/api_response.dart';
import 'package:easy_hris/data/models/employee_model.dart';
import 'package:easy_hris/data/models/employee_response_model.dart';
import 'package:easy_hris/data/models/id_name_model.dart';
import 'package:easy_hris/data/models/marital_model.dart';
import 'package:easy_hris/data/models/religion_model.dart';
import 'package:easy_hris/data/models/request/career_request.dart';
import 'package:easy_hris/data/models/request/education_request.dart';
import 'package:easy_hris/data/models/request/experience_request.dart';
import 'package:easy_hris/data/models/request/family_request.dart';
import 'package:easy_hris/data/models/request/personal_data_update_request.dart';
import 'package:easy_hris/data/models/request/training_request.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../../constant/constant.dart';
import 'package:http/http.dart' as http;

class ApiEmployee {
  Future<ApiResponse<List<IdNameModel>>> fetchMaster(String source) async {
    Uri url = Uri.parse("${Constant.baseUrl}/api/master/reads?source=$source");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      print("result => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => IdNameModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<List<ReligionModel>>> fetchReligion(String source) async {
    Uri url = Uri.parse("${Constant.baseUrl}/api/master/reads?source=$source");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      print("result => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => ReligionModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<List<MaritalModel>>> fetchMarital(String source) async {
    Uri url = Uri.parse("${Constant.baseUrl}/api/master/reads?source=$source");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      print("result => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => MaritalModel.fromJsonList(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<EmployeeModel>> fetchEmployee(String numberUser) async {
    Uri url = Uri.parse("${Constant.baseUrl}/api/employees/reads?number=$numberUser");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      print("result => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => EmployeeModel.fromJson(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      print("traceee $trace");
      throw Exception("${ConstantMessage.errMsg} $e");
    }
  }

  Future<ApiResponse<EmployeeResponseModel>> fetchEmployeeUser(String numberUser) async {
    print("call");
    Uri url = Uri.parse("${Constant.baseUrl}/api/employees/reads?number=$numberUser");

    try {
      var response = await http.get(url);

      Map<String, dynamic> result = jsonDecode(response.body);

      print("result fetchEmployeeuser => $result");

      return ApiResponse.fromJson(result, onDataSerialized: (_) => null, onDataDeserialized: (json) => EmployeeResponseModel.fromJson(json));
    } on TimeoutException catch (_) {
      throw Exception(ConstantMessage.errMsgTimeOut);
    } on SocketException catch (_) {
      throw Exception(ConstantMessage.errMsgNoInternet);
    } catch (e, trace) {
      print("traceee $trace");
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
    print("call");
    Uri url = Uri.parse("${Constant.baseUrl}/api/employees/updateData");

    try {
      final request = http.MultipartRequest("POST", url);

      final req = requestUser.toJson();

      request.fields.addAll(req);

      print("ktp => ${fileNationalID.path}");
      print("kk => ${fileKK.path}");
      print("tax => ${fileTax.path}");
      print("pr => ${fileImageProfile.path}");

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

      print("response $response");
      print("response ${response.reasonPhrase}");
      // baca stream jadi string
      final responseBody = await response.stream.bytesToString();

      print("status code => ${response.statusCode}");
      print("body => $responseBody");

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
    print("call");
    Uri url = Uri.parse("${Constant.baseUrl}/api/employees/createFamily");

    try {
      var response = await http.post(url, body: request.toJson());

      Map<String, dynamic> result = jsonDecode(response.body);

      debugPrint("result addFamily => $result");

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

  Future<ApiResponse> deleteEmployee(String id, String number, String enpoint) async {
    print("call");
    Uri url = Uri.parse("${Constant.baseUrl}/api/employees/$enpoint");

    try {
      var response = await http.post(url, body: {"id": id, "number": number});

      Map<String, dynamic> result = jsonDecode(response.body);

      debugPrint("result addFamily => $result");

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

  Future<ApiResponse> addEducation(EducationRequest request) async {
    print("call");
    Uri url = Uri.parse("${Constant.baseUrl}/api/employees/createEducation");

    try {
      var response = await http.post(url, body: request.toJson());

      Map<String, dynamic> result = jsonDecode(response.body);

      debugPrint("result add educ => $result");

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

  Future<ApiResponse> addExperience(ExperienceRequest request) async {
    print("call");
    Uri url = Uri.parse("${Constant.baseUrl}/api/employees/createExperience");

    try {
      var response = await http.post(url, body: request.toJson());

      Map<String, dynamic> result = jsonDecode(response.body);

      debugPrint("result add educ => $result");

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

  Future<ApiResponse> addTraining(TrainingRequest request) async {
    print("call");
    Uri url = Uri.parse("${Constant.baseUrl}/api/employees/createTraining");

    try {
      var response = await http.post(url, body: request.toJson());

      Map<String, dynamic> result = jsonDecode(response.body);

      debugPrint("result add educ => $result");

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

  Future<ApiResponse> addCareer(CareerRequest request) async {
    print("call");
    Uri url = Uri.parse("${Constant.baseUrl}/api/employees/createCarrer");

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

  Future<File> urlToFile(String imageUrl, {String? fileName}) async {
    // print("IMAGE URL => $imageUrl");
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode != 200) {
      throw Exception('Gagal download gambar');
    }

    Uint8List bytes = response.bodyBytes;

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${fileName ?? 'image_$fileName.png'}');

    await file.writeAsBytes(bytes);

    return file;
  }
}

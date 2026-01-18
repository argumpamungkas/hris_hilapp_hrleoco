import 'dart:convert';

import 'package:easy_hris/data/models/response/contract_model.dart';
import 'package:easy_hris/data/models/response/department_model.dart';
import 'package:easy_hris/data/models/response/department_sub_model.dart';
import 'package:easy_hris/data/models/response/division_model.dart';
import 'package:easy_hris/data/models/response/employee_agreement_model.dart';
import 'package:easy_hris/data/models/response/employee_career_model.dart';
import 'package:easy_hris/data/models/response/employee_education_model.dart';
import 'package:easy_hris/data/models/response/employee_experience_model.dart';
import 'package:easy_hris/data/models/response/employee_families_model.dart';
import 'package:easy_hris/data/models/response/employee_model.dart';
import 'package:easy_hris/data/models/response/employee_training_model.dart';
import 'package:easy_hris/data/models/response/group_model.dart';
import 'package:easy_hris/data/models/response/marital_model.dart';
import 'package:easy_hris/data/models/response/position_model.dart';
import 'package:easy_hris/data/models/response/religion_model.dart';
import 'package:easy_hris/data/models/temporary_model.dart';

EmployeeResponseModel employeeResponseModelFromJson(String str) => EmployeeResponseModel.fromJson(json.decode(str));

String employeeResponseModelToJson(EmployeeResponseModel data) => json.encode(data.toJson());

class EmployeeResponseModel {
  Employee? employee;
  List<TemporaryModel> temporary;
  DivisionModel? division;
  DepartmentModel? departement;
  DepartmentSubModel? departementSub;
  ContractModel? contract;
  PositionModel? position;
  GroupModel? group;
  MaritalModel? marital;
  ReligionModel? religion;
  String? resignation;
  String? service;
  String? source;
  List<EmployeeFamiliesModel> employeeFamilies;
  List<EmployeeEducationModel> employeeEducations;
  List<EmployeeExperienceModel> employeeExperiences;
  List<EmployeeTrainingModel> employeeTrainings;
  List<EmployeeCareerModel> employeeCarrers;
  // List<EmployeeAgreementModel> employeeAgreements;

  EmployeeResponseModel({
    required this.employee,
    required this.temporary,
    required this.division,
    required this.departement,
    required this.departementSub,
    required this.contract,
    required this.position,
    required this.group,
    required this.marital,
    required this.religion,
    required this.resignation,
    required this.service,
    required this.source,
    required this.employeeFamilies,
    required this.employeeEducations,
    required this.employeeExperiences,
    required this.employeeTrainings,
    required this.employeeCarrers,
    // required this.employeeAgreements,
  });

  factory EmployeeResponseModel.fromJson(Map<String, dynamic> json) => EmployeeResponseModel(
    employee: json['employee'] == null ? null : Employee.fromJson(json['employee']),
    temporary: json["temporary"]! != [] ? List<TemporaryModel>.from(json["temporary"].map((x) => TemporaryModel.fromJson(x))) : [],
    division: json['division'] == null ? null : DivisionModel.fromJson(json['division']),
    departement: json['departement'] == null ? null : DepartmentModel.fromJson(json['departement']),
    departementSub: json['departement_sub'] == null ? null : DepartmentSubModel.fromJson(json['departement_sub']),
    contract: json['contract'] == null ? null : ContractModel.fromJson(json['contract']),
    position: json['position'] == null ? null : PositionModel.fromJson(json['position']),
    group: json['group'] == null ? null : GroupModel.fromJson(json['group']),
    marital: json['marital'] == null ? null : MaritalModel.fromJson(json['marital']),
    religion: json['religion'] == null ? null : ReligionModel.fromJson(json['religion']),
    resignation: json["resignation"] ?? "",
    service: json["service"] ?? "",
    source: json["source"] ?? "",
    employeeFamilies: json["employee_families"]! != []
        ? List<EmployeeFamiliesModel>.from(json["employee_families"].map((x) => EmployeeFamiliesModel.fromJson(x)))
        : [],
    employeeEducations: json["employee_educations"]! != []
        ? List<EmployeeEducationModel>.from(json["employee_educations"].map((x) => EmployeeEducationModel.fromJson(x)))
        : [],
    employeeExperiences: json["employee_experiences"]! != []
        ? List<EmployeeExperienceModel>.from(json["employee_experiences"].map((x) => EmployeeExperienceModel.fromJson(x)))
        : [],
    employeeTrainings: json["employee_trainings"]! != []
        ? List<EmployeeTrainingModel>.from(json["employee_trainings"].map((x) => EmployeeTrainingModel.fromJson(x)))
        : [],
    employeeCarrers: json["employee_carrers"]! != []
        ? List<EmployeeCareerModel>.from(json["employee_carrers"].map((x) => EmployeeCareerModel.fromJson(x)))
        : [],
    // employeeAgreements: json["employee_agreements"] != []
    //     ? List<EmployeeAgreementModel>.from(json["employee_agreements"].map((x) => EmployeeAgreementModel.fromJson(x)))
    //     : [],
  );

  Map<String, dynamic> toJson() => {
    "employee": employee?.toJson(),
    "temporary": List<dynamic>.from(temporary.map((x) => x)),
    "division": division?.toJson(),
    "departement": departement?.toJson(),
    "departement_sub": departementSub?.toJson(),
    "contract": contract?.toJson(),
    "position": position?.toJson(),
    "group": group?.toJson(),
    "marital": marital?.toJson(),
    "religion": religion?.toJson(),
    "resignation": resignation,
    "service": service,
    "source": source,
    "employee_families": List<dynamic>.from(employeeFamilies.map((x) => x)),
    "employee_educations": List<dynamic>.from(employeeEducations.map((x) => x)),
    "employee_experiences": List<dynamic>.from(employeeExperiences.map((x) => x)),
    "employee_trainings": List<dynamic>.from(employeeTrainings.map((x) => x)),
    "employee_carrers": List<dynamic>.from(employeeCarrers.map((x) => x?.toJson())),
    // "employee_agreements": List<dynamic>.from(employeeAgreements.map((x) => x.toJson())),
  };
}

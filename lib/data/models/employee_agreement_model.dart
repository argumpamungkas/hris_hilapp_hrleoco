import 'dart:convert';

EmployeeAgreementModel employeeAgreementModelFromJson(String str) => EmployeeAgreementModel.fromJson(json.decode(str));

String employeeAgreementModelToJson(EmployeeAgreementModel data) => json.encode(data.toJson());

class EmployeeAgreementModel {
  String? dateSign;
  String? dateExpired;
  String? contractName;

  EmployeeAgreementModel({required this.dateSign, required this.dateExpired, required this.contractName});

  factory EmployeeAgreementModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAgreementModel(dateSign: json["date_sign"] ?? "", dateExpired: json["date_expired"] ?? "", contractName: json["contract_name"] ?? "");

  Map<String, dynamic> toJson() => {"date_sign": dateSign, "date_expired": dateExpired, "contract_name": contractName};
}

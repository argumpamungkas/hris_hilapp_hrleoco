import 'dart:convert';

ShiftUserModel shiftUserModelFromJson(String str) => ShiftUserModel.fromJson(json.decode(str));

String shiftUserModelToJson(ShiftUserModel data) => json.encode(data.toJson());

class ShiftUserModel {
  String? employeeStatus;
  String? imageProfile;
  String? shiftName;
  String? shiftStart;
  String? shiftEnd;

  ShiftUserModel({
    required this.employeeStatus,
    required this.imageProfile,
    required this.shiftName,
    required this.shiftStart,
    required this.shiftEnd,
  });

  factory ShiftUserModel.fromJson(Map<String, dynamic> json) => ShiftUserModel(
    employeeStatus: json["employee_status"] ?? '0',
    imageProfile: json["image_profile"] ?? "",
    shiftName: json["shift_name"] ?? "",
    shiftStart: json["shift_start"] ?? "",
    shiftEnd: json["shift_end"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "employee_status": employeeStatus,
    "image_profile": imageProfile,
    "shift_name": shiftName,
    "shift_start": shiftStart,
    "shift_end": shiftEnd,
  };
}

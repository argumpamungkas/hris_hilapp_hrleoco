class PermitModel {
  String title;
  String message;
  int remaining;
  List<ResultPermitModel> result;
  String theme;

  PermitModel({required this.title, required this.message, required this.remaining, required this.result, required this.theme});

  factory PermitModel.fromJson(Map<String, dynamic> json) => PermitModel(
    title: json["title"],
    message: json["message"],
    remaining: json["remaining"],
    result: List<ResultPermitModel>.from(json["result"].map((x) => ResultPermitModel.fromJson(x))),
    theme: json["theme"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "remaining": remaining,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "theme": theme,
  };
}

class ResultPermitModel {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? approved;
  String? approvedTo;
  String? approvedBy;
  String? approvedDate;
  String? approvedData;
  String? deleted;
  String? employeeId;
  String? permitTypeId;
  String? reasonId;
  String? transDate;
  String? permitDate;
  String? workingDay;
  String? duration;
  String? leave;
  String? startTime;
  String? endTime;
  String? meal;
  String? note;
  String? attachment;
  String? status;
  String? dateFrom;
  String? dateTo;
  String? employeeNumber;
  String? employeeName;
  String? divisionName;
  String? departementName;
  String? departementSubName;
  String? permitTypeName;
  String? permitMeal;
  String? reasonName;
  String? requestName;

  ResultPermitModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.approved,
    required this.approvedTo,
    required this.approvedBy,
    required this.approvedDate,
    required this.approvedData,
    required this.deleted,
    required this.employeeId,
    required this.permitTypeId,
    required this.reasonId,
    required this.transDate,
    required this.permitDate,
    required this.workingDay,
    required this.duration,
    required this.leave,
    required this.startTime,
    required this.endTime,
    required this.meal,
    required this.note,
    required this.attachment,
    required this.status,
    required this.dateFrom,
    required this.dateTo,
    required this.employeeNumber,
    required this.employeeName,
    required this.divisionName,
    required this.departementName,
    required this.departementSubName,
    required this.permitTypeName,
    required this.permitMeal,
    required this.reasonName,
    required this.requestName,
  });

  factory ResultPermitModel.fromJson(Map<String, dynamic> json) => ResultPermitModel(
    id: json["id"] ?? "",
    createdBy: json["created_by"] ?? "",
    createdDate: json["created_date"] ?? "",
    updatedBy: json["updated_by"] ?? "",
    updatedDate: json["updated_date"] ?? "",
    approved: json["approved"] ?? "",
    approvedTo: json["approved_to"] ?? "-",
    approvedBy: json["approved_by"] ?? "-",
    approvedDate: json["approved_date"] ?? "",
    approvedData: json["approved_data"] ?? "",
    deleted: json["deleted"] ?? "",
    employeeId: json["employee_id"] ?? "",
    permitTypeId: json["permit_type_id"] ?? "",
    reasonId: json["reason_id"] ?? "",
    transDate: json["trans_date"] ?? "",
    permitDate: json["permit_date"] ?? "",
    workingDay: json["working_day"] ?? "",
    duration: json["duration"] ?? "",
    leave: json["leave"] ?? "",
    startTime: json["start_time"] ?? "",
    endTime: json["end_time"] ?? "",
    meal: json["meal"] ?? "",
    note: json["note"] ?? "",
    attachment: json["attachment"] ?? "",
    status: json["status"] ?? "",
    dateFrom: json["date_from"] ?? "",
    dateTo: json["date_to"] ?? "",
    employeeNumber: json["employee_number"] ?? "",
    employeeName: json["employee_name"] ?? "",
    divisionName: json["division_name"] ?? "",
    departementName: json["departement_name"] ?? "",
    departementSubName: json["departement_sub_name"] ?? "",
    permitTypeName: json["permit_type_name"] ?? "",
    permitMeal: json["permit_meal"] ?? "",
    reasonName: json["reason_name"] ?? "",
    requestName: json["request_name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "created_date": createdDate,
    "updated_by": updatedBy,
    "updated_date": updatedDate,
    "approved": approved,
    "approved_to": approvedTo,
    "approved_by": approvedBy,
    "approved_date": approvedDate,
    "approved_data": approvedData,
    "deleted": deleted,
    "employee_id": employeeId,
    "permit_type_id": permitTypeId,
    "reason_id": reasonId,
    "trans_date": transDate,
    "permit_date": permitDate,
    "working_day": workingDay,
    "duration": duration,
    "leave": leave,
    "start_time": startTime,
    "end_time": endTime,
    "meal": meal,
    "note": note,
    "attachment": attachment,
    "status": status,
    "date_from": dateFrom,
    "date_to": dateTo,
    "employee_number": employeeNumber,
    "employee_name": employeeName,
    "division_name": divisionName,
    "departement_name": departementName,
    "departement_sub_name": departementSubName,
    "permit_type_name": permitTypeName,
    "permit_meal": permitMeal,
    "reason_name": reasonName,
    "request_name": requestName,
  };
}

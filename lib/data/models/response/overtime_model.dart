class OvertimeModel {
  String title;
  String message;
  int? totalDuration;
  int? totalAmount;
  List<ResultOvertimeModel> result;
  String theme;

  OvertimeModel({
    required this.title,
    required this.message,
    required this.totalDuration,
    required this.totalAmount,
    required this.result,
    required this.theme,
  });

  factory OvertimeModel.fromJson(Map<String, dynamic> json) => OvertimeModel(
    title: json["title"],
    message: json["message"],
    totalDuration: json["total_duration"] ?? 0,
    totalAmount: json["total_amount"] ?? 0,
    result: List<ResultOvertimeModel>.from(json["result"].map((x) => ResultOvertimeModel.fromJson(x))),
    theme: json["theme"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "total_duration": totalDuration,
    "total_amount": totalAmount,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "theme": theme,
  };
}

class ResultOvertimeModel {
  String? id;
  String? createdBy;
  DateTime? createdDate;
  String? updatedBy;
  DateTime? updatedDate;
  String? approved;
  String? approvedTo;
  String? approvedBy;
  DateTime? approvedDate;
  String? deleted;
  String? employeeId;
  String? transDate;
  String? requestCode;
  String? documentNo;
  String? start;
  String? end;
  String? overtimeModelBreak;
  String? type;
  String? duration;
  String? durationHour;
  String? durationConvert;
  String? meal;
  String? amount;
  String? remarks;
  String? plan;
  String? actual;
  String? attachment;
  String? statusOt;
  String? status;
  String? employeeNumber;
  String? employeeName;
  String? attendanceIn;
  String? attendanceOut;
  String? overtimeMeal;
  String? attendanceDuration;
  String? overtimeStatus;
  int? overtimeAmount;

  ResultOvertimeModel({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.approved,
    required this.approvedTo,
    required this.approvedBy,
    required this.approvedDate,
    required this.deleted,
    required this.employeeId,
    required this.transDate,
    required this.requestCode,
    required this.documentNo,
    required this.start,
    required this.end,
    required this.overtimeModelBreak,
    required this.type,
    required this.duration,
    required this.durationHour,
    required this.durationConvert,
    required this.meal,
    required this.amount,
    required this.remarks,
    required this.plan,
    required this.actual,
    required this.attachment,
    required this.statusOt,
    required this.status,
    required this.employeeNumber,
    required this.employeeName,
    required this.attendanceIn,
    required this.attendanceOut,
    required this.overtimeMeal,
    required this.attendanceDuration,
    required this.overtimeStatus,
    required this.overtimeAmount,
  });

  factory ResultOvertimeModel.fromJson(Map<String, dynamic> json) => ResultOvertimeModel(
    id: json["id"] ?? '',
    createdBy: json["created_by"] ?? '',
    createdDate: DateTime.parse(json["created_date"]),
    updatedBy: json["updated_by"] ?? '',
    updatedDate: DateTime.parse(json["updated_date"]),
    approved: json["approved"] ?? '',
    approvedTo: json["approved_to"] ?? '',
    approvedBy: json["approved_by"] ?? '',
    approvedDate: DateTime.parse(json["approved_date"]),
    deleted: json["deleted"] ?? '',
    employeeId: json["employee_id"] ?? '',
    transDate: json["trans_date"] ?? '',
    requestCode: json["request_code"] ?? '',
    documentNo: json["document_no"] ?? '',
    start: json["start"] ?? '',
    end: json["end"] ?? '',
    overtimeModelBreak: json["break"] ?? '',
    type: json["type"] ?? '',
    duration: json["duration"] ?? '',
    durationHour: json["duration_hour"] ?? '',
    durationConvert: json["duration_convert"] ?? '',
    meal: json["meal"] ?? '',
    amount: json["amount"] ?? '0',
    remarks: json["remarks"] ?? '',
    plan: json["plan"] ?? '',
    actual: json["actual"] ?? '',
    attachment: json["attachment"] ?? '',
    statusOt: json["status_ot"] ?? '',
    status: json["status"] ?? '',
    employeeNumber: json["employee_number"] ?? '',
    employeeName: json["employee_name"] ?? '',
    attendanceIn: json["attandance_in"] ?? '',
    attendanceOut: json["attandance_out"] ?? '',
    overtimeMeal: json["overtime_meal"] ?? '0',
    attendanceDuration: json["attandance_duration"] ?? '',
    overtimeStatus: json["overtime_status"] ?? '',
    overtimeAmount: json["overtime_amount"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "created_date": createdDate?.toIso8601String(),
    "updated_by": updatedBy,
    "updated_date": updatedDate?.toIso8601String(),
    "approved": approved,
    "approved_to": approvedTo,
    "approved_by": approvedBy,
    "approved_date": approvedDate?.toIso8601String(),
    "deleted": deleted,
    "employee_id": employeeId,
    "trans_date": transDate,
    "request_code": requestCode,
    "document_no": documentNo,
    "start": start,
    "end": end,
    "break": overtimeModelBreak,
    "type": type,
    "duration": duration,
    "duration_hour": durationHour,
    "duration_convert": durationConvert,
    "meal": meal,
    "amount": amount,
    "remarks": remarks,
    "plan": plan,
    "actual": actual,
    "attachment": attachment,
    "status_ot": statusOt,
    "status": status,
    "employee_number": employeeNumber,
    "employee_name": employeeName,
    "attandance_in": attendanceIn,
    "attandance_out": attendanceOut,
    "overtime_meal": overtimeMeal,
    "attandance_duration": attendanceDuration,
    "overtime_status": overtimeStatus,
    "overtime_amount": overtimeAmount,
  };

  static List<ResultOvertimeModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ResultOvertimeModel.fromJson(json)).toList();
  }
}

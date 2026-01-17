class NotificationDetailResponseOvertime {
  String title;
  String message;
  String theme;
  List<ResultNotificationDetailOvertime> results;

  NotificationDetailResponseOvertime({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory NotificationDetailResponseOvertime.fromJson(
          Map<String, dynamic> json) =>
      NotificationDetailResponseOvertime(
        title: json["title"],
        message: json["message"],
        theme: json["theme"],
        results: List<ResultNotificationDetailOvertime>.from(json["results"]
            .map((x) => ResultNotificationDetailOvertime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "theme": theme,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultNotificationDetailOvertime {
  String id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? approved;
  String? approvedTo;
  String? approvedBy;
  String? approvedDate;
  String? deleted;
  String? employeeId;
  String? transDate;
  String? requestCode;
  String? requestName;
  String? start;
  String? end;
  String? resBreak;
  String? type;
  String? duration;
  String? durationHour;
  String? durationConvert;
  String? meal;
  String? amount;
  String? plan;
  String? actual;
  String? remarks;
  String? idmNo;
  String? attachmentIdm;
  String? attachment;
  String? status;
  String? divisionName;
  String? departementName;
  String? departementSubName;
  String? employeeNumber;
  String? employeeName;
  String? fileAttachment;

  ResultNotificationDetailOvertime(
      {required this.id,
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
      required this.requestName,
      required this.start,
      required this.end,
      required this.resBreak,
      required this.type,
      required this.duration,
      required this.durationHour,
      required this.durationConvert,
      required this.meal,
      required this.amount,
      required this.plan,
      required this.actual,
      required this.remarks,
      required this.idmNo,
      required this.attachmentIdm,
      required this.attachment,
      required this.status,
      required this.divisionName,
      required this.departementName,
      required this.departementSubName,
      required this.employeeNumber,
      required this.employeeName,
      required this.fileAttachment});

  factory ResultNotificationDetailOvertime.fromJson(
          Map<String, dynamic> json) =>
      ResultNotificationDetailOvertime(
        id: json["id"],
        createdBy: json["created_by"] ?? "-",
        createdDate: json["created_date"] ?? "-",
        updatedBy: json["updated_by"] ?? "-",
        updatedDate: json["updated_date"] ?? "-",
        approved: json["approved"] ?? "-",
        approvedTo: json["approved_to"] ?? "-",
        approvedBy: json["approved_by"] ?? "-",
        approvedDate: json["approved_date"] ?? "-",
        deleted: json["deleted"] ?? "-",
        employeeId: json["employee_id"] ?? "-",
        transDate: json["trans_date"] ?? "-",
        requestCode: json["request_code"] ?? "-",
        requestName: json["request_name"] ?? "-",
        start: json["start"] ?? "-",
        end: json["end"] ?? "-",
        resBreak: json["break"] ?? "-",
        type: json["type"] ?? "-",
        duration: json["duration"] ?? "-",
        durationHour: json["duration_hour"] ?? "-",
        durationConvert: json["duration_convert"] ?? "-",
        meal: json["meal"] ?? "-",
        amount: json["amount"] ?? "-",
        plan: json["plan"] ?? "-",
        actual: json["actual"] ?? "-",
        remarks: json["remarks"] ?? "-",
        idmNo: json["idm_no"] ?? "-",
        attachmentIdm: json["attachment_idm"] ?? "-",
        attachment: json["attachment"] ?? "-",
        status: json["status"] ?? "-",
        divisionName: json["division_name"] ?? "-",
        departementName: json["departement_name"] ?? "-",
        departementSubName: json["departement_sub_name"] ?? "-",
        employeeNumber: json["employee_number"] ?? "-",
        employeeName: json["employee_name"] ?? "-",
        fileAttachment: json["file_attachment"],
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
        "deleted": deleted,
        "employee_id": employeeId,
        "trans_date": transDate,
        "request_code": requestCode,
        "request_name": requestName,
        "start": start,
        "end": end,
        "break": resBreak,
        "type": type,
        "duration": duration,
        "duration_hour": durationHour,
        "duration_convert": durationConvert,
        "meal": meal,
        "amount": amount,
        "plan": plan,
        "actual": actual,
        "remarks": remarks,
        "idm_no": idmNo,
        "attachment_idm": attachmentIdm,
        "attachment": attachment,
        "status": status,
        "division_name": divisionName,
        "departement_name": departementName,
        "departement_sub_name": departementSubName,
        "employee_number": employeeNumber,
        "employee_name": employeeName,
        "file_attachment": fileAttachment,
      };
}

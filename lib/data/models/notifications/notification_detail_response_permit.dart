class NotificationDetailResponsePermit {
  String title;
  String message;
  String theme;
  List<ResultNotificationDetailPermit> results;

  NotificationDetailResponsePermit({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory NotificationDetailResponsePermit.fromJson(Map<String, dynamic> json) {
    return NotificationDetailResponsePermit(
      title: json['title'],
      message: json['message'],
      theme: json['theme'],
      results: List<ResultNotificationDetailPermit>.from(
        json['results'].map(
          (x) => ResultNotificationDetailPermit.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "theme": theme,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultNotificationDetailPermit {
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
  String? permitTypeId;
  String? reasonId;
  String? transDate;
  String? permitDate;
  String? duration;
  String? leave;
  String? note;
  String? attachment;
  String? status;
  String? employeeNumber;
  String? employeeName;
  String? divisionName;
  String? departementName;
  String? departementSubName;
  String? permitTypeName;
  String? reasonName;
  String? requestName;
  String? fileAttachment;

  ResultNotificationDetailPermit({
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
    required this.permitTypeId,
    required this.reasonId,
    required this.transDate,
    required this.permitDate,
    required this.duration,
    required this.leave,
    required this.note,
    required this.attachment,
    required this.status,
    required this.employeeNumber,
    required this.employeeName,
    required this.divisionName,
    required this.departementName,
    required this.departementSubName,
    required this.permitTypeName,
    required this.reasonName,
    required this.requestName,
    required this.fileAttachment,
  });

  factory ResultNotificationDetailPermit.fromJson(Map<String, dynamic> json) =>
      ResultNotificationDetailPermit(
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
        permitTypeId: json["permit_type_id"] ?? "-",
        reasonId: json["reason_id"] ?? "-",
        transDate: json["trans_date"] ?? "-",
        permitDate: json["permit_date"] ?? "-",
        duration: json["duration"] ?? "-",
        leave: json["leave"] ?? "-",
        note: json["note"] ?? "-",
        attachment: json["attachment"] ?? "-",
        status: json["status"] ?? "-",
        employeeNumber: json["employee_number"] ?? "-",
        employeeName: json["employee_name"] ?? "-",
        divisionName: json["division_name"] ?? "-",
        departementName: json["departement_name"] ?? "-",
        departementSubName: json["departement_sub_name"] ?? "-",
        permitTypeName: json["permit_type_name"] ?? "-",
        reasonName: json["reason_name"] ?? "-",
        requestName: json["request_name"] ?? "-",
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
        "permit_type_id": permitTypeId,
        "reason_id": reasonId,
        "trans_date": transDate,
        "permit_date": permitDate,
        "duration": duration,
        "leave": leave,
        "note": note,
        "attachment": attachment,
        "status": status,
        "employee_number": employeeNumber,
        "employee_name": employeeName,
        "division_name": divisionName,
        "departement_name": departementName,
        "departement_sub_name": departementSubName,
        "permit_type_name": permitTypeName,
        "reason_name": reasonName,
        "request_name": requestName,
        "file_attachment": fileAttachment,
      };
}

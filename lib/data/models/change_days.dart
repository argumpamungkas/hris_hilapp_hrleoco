class ChangeDays {
  String title;
  String message;
  String theme;
  List<ResultsChangeDays> results;

  ChangeDays({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory ChangeDays.fromJson(Map<String, dynamic> json) => ChangeDays(
        title: json["title"],
        message: json["message"],
        theme: json["theme"],
        results: List<ResultsChangeDays>.from(
            json["results"].map((x) => ResultsChangeDays.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "theme": theme,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultsChangeDays {
  String? id;
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
  String? requestCode;
  String? start;
  String? end;
  String? remarks;
  String? status;
  String? divisionName;
  String? departementName;
  String? departementSubName;
  String? employeeNumber;
  String? employeeName;
  String? fullname;

  ResultsChangeDays({
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
    required this.requestCode,
    required this.start,
    required this.end,
    required this.remarks,
    required this.status,
    required this.divisionName,
    required this.departementName,
    required this.departementSubName,
    required this.employeeNumber,
    required this.employeeName,
    required this.fullname,
  });

  factory ResultsChangeDays.fromJson(Map<String, dynamic> json) =>
      ResultsChangeDays(
        id: json["id"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
        approved: json["approved"],
        approvedTo: json["approved_to"],
        approvedBy: json["approved_by"],
        approvedDate: json["approved_date"],
        deleted: json["deleted"],
        employeeId: json["employee_id"],
        requestCode: json["request_code"],
        start: json["start"],
        end: json["end"],
        remarks: json["remarks"],
        status: json["status"],
        divisionName: json["division_name"],
        departementName: json["departement_name"],
        departementSubName: json["departement_sub_name"],
        employeeNumber: json["employee_number"],
        employeeName: json["employee_name"],
        fullname: json["fullname"],
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
        "request_code": requestCode,
        "start": start,
        "end": end,
        "remarks": remarks,
        "status": status,
        "division_name": divisionName,
        "departement_name": departementName,
        "departement_sub_name": departementSubName,
        "employee_number": employeeNumber,
        "employee_name": employeeName,
        "fullname": fullname,
      };
}

class ResponseChangeDays {
  String title;
  String message;
  String theme;

  ResponseChangeDays({
    required this.title,
    required this.message,
    required this.theme,
  });

  factory ResponseChangeDays.fromJson(Map<String, dynamic> json) =>
      ResponseChangeDays(
        title: json['title'],
        message: json['message'],
        theme: json['theme'],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "theme": theme,
      };
}

class PermitType {
  String id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
  String? number;
  String? name;
  String? payroll;
  String? cutoff;
  String? absence;
  String? attandance;
  String? attachment;
  String? status;

  PermitType({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
    required this.number,
    required this.name,
    required this.payroll,
    required this.cutoff,
    required this.absence,
    required this.attandance,
    required this.attachment,
    required this.status,
  });

  factory PermitType.fromJson(Map<String, dynamic> json) => PermitType(
        id: json["id"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
        deleted: json["deleted"],
        number: json["number"],
        name: json["name"],
        payroll: json["payroll"],
        cutoff: json["cutoff"],
        absence: json["absence"],
        attandance: json["attandance"],
        attachment: json["attachment"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
        "deleted": deleted,
        "number": number,
        "name": name,
        "payroll": payroll,
        "cutoff": cutoff,
        "absence": absence,
        "attandance": attandance,
        "attachment": attachment,
        "status": status,
      };
}

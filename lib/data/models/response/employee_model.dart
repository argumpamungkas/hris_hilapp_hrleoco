class EmployeeModel {
  Employee employee;

  EmployeeModel({required this.employee});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(employee: Employee.fromJson(json["employee"]));

  Map<String, dynamic> toJson() => {"employee": employee.toJson()};
}

class Employee {
  String? id;
  String? candidateId;
  String? divisionId;
  String? departementId;
  String? departementSubId;
  String? contractId;
  String? positionId;
  String? groupId;
  String? sourceId;
  String? maritalId;
  String? religionId;
  String? shiftId;
  String? machineId;
  String? number;
  String? name;
  String? nickname;
  String? dateSign;
  String? dateExpired;
  String? address;
  String? domicile;
  String? placeBirth;
  String? birthday;
  String? gender;
  String? blood;
  String? nationalId;
  String? taxId;
  String? jamsostek;
  String? jamsostekDate;
  String? jkn;
  String? jknDate;
  String? jknFamily;
  String? telphone;
  String? mobilePhone;
  String? emergencyNo;
  String? email;
  String? drivingNo;
  String? drivingDate;
  String? stnkNo;
  String? stnkDate;
  String? kkNo;
  String? maps;
  String? imageId;
  String? imageNpwp;
  String? imageKk;
  String? imageProfile;
  String? bankName;
  String? bankNo;
  String? bankBranch;
  String? status;
  String? statusDate;

  Employee({
    required this.id,
    required this.candidateId,
    required this.divisionId,
    required this.departementId,
    required this.departementSubId,
    required this.contractId,
    required this.positionId,
    required this.groupId,
    required this.sourceId,
    required this.maritalId,
    required this.religionId,
    required this.shiftId,
    required this.machineId,
    required this.number,
    required this.name,
    required this.nickname,
    required this.dateSign,
    required this.dateExpired,
    required this.address,
    required this.domicile,
    required this.placeBirth,
    required this.birthday,
    required this.gender,
    required this.blood,
    required this.nationalId,
    required this.taxId,
    required this.jamsostek,
    required this.jamsostekDate,
    required this.jkn,
    required this.jknDate,
    required this.jknFamily,
    required this.telphone,
    required this.mobilePhone,
    required this.emergencyNo,
    required this.email,
    required this.drivingNo,
    required this.drivingDate,
    required this.stnkNo,
    required this.stnkDate,
    required this.kkNo,
    required this.maps,
    required this.imageId,
    required this.imageNpwp,
    required this.imageKk,
    required this.imageProfile,
    required this.bankName,
    required this.bankNo,
    required this.bankBranch,
    required this.status,
    required this.statusDate,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"] ?? "",
    candidateId: json["candidate_id"] ?? "",
    divisionId: json["division_id"] ?? "",
    departementId: json["departement_id"] ?? "",
    departementSubId: json["departement_sub_id"] ?? "",
    contractId: json["contract_id"] ?? "",
    positionId: json["position_id"] ?? "",
    groupId: json["group_id"] ?? "",
    sourceId: json["source_id"] ?? "",
    maritalId: json["marital_id"] ?? "",
    religionId: json["religion_id"] ?? "",
    shiftId: json["shift_id"] ?? "",
    machineId: json["machine_id"] ?? "",
    number: json["number"] ?? "",
    name: json["name"] ?? "",
    nickname: json["nickname"] ?? "",
    dateSign: json["date_sign"] ?? "",
    dateExpired: json["date_expired"] ?? "",
    address: json["address"] ?? "",
    domicile: json["domicile"] ?? "",
    placeBirth: json["place_birth"] ?? "",
    birthday: json["birthday"] ?? "",
    gender: json["gender"] ?? "",
    blood: json["blood"] ?? "",
    nationalId: json["national_id"] ?? "",
    taxId: json["tax_id"] ?? "",
    jamsostek: json["jamsostek"] ?? "",
    jamsostekDate: json["jamsostek_date"] ?? "",
    jkn: json["jkn"] ?? "",
    jknDate: json["jkn_date"] ?? "",
    jknFamily: json["jkn_family"] ?? "",
    telphone: json["telphone"] ?? "",
    mobilePhone: json["mobile_phone"] ?? "",
    emergencyNo: json["emergency_no"] ?? "",
    email: json["email"] ?? "",
    drivingNo: json["driving_no"] ?? "",
    drivingDate: json["driving_date"] ?? "",
    stnkNo: json["stnk_no"] ?? "",
    stnkDate: json["stnk_date"] ?? "",
    kkNo: json["kk_no"] ?? "",
    maps: json["maps"] ?? "",
    imageId: json["image_id"] ?? "",
    imageNpwp: json["image_npwp"] ?? "",
    imageKk: json["image_kk"] ?? "",
    imageProfile: json["image_profile"] ?? "",
    bankName: json["bank_name"] ?? "",
    bankNo: json["bank_no"] ?? "",
    bankBranch: json["bank_branch"] ?? "",
    status: json["status"] ?? "",
    statusDate: json["status_date"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "candidate_id": candidateId,
    "division_id": divisionId,
    "departement_id": departementId,
    "departement_sub_id": departementSubId,
    "contract_id": contractId,
    "position_id": positionId,
    "group_id": groupId,
    "source_id": sourceId,
    "marital_id": maritalId,
    "religion_id": religionId,
    "shift_id": shiftId,
    "machine_id": machineId,
    "number": number,
    "name": name,
    "nickname": nickname,
    "date_sign": dateSign,
    "date_expired": dateExpired,
    "address": address,
    "domicile": domicile,
    "place_birth": placeBirth,
    "birthday": birthday,
    "gender": gender,
    "blood": blood,
    "national_id": nationalId,
    "tax_id": taxId,
    "jamsostek": jamsostek,
    "jamsostek_date": jamsostekDate,
    "jkn": jkn,
    "jkn_date": jknDate,
    "jkn_family": jknFamily,
    "telphone": telphone,
    "mobile_phone": mobilePhone,
    "emergency_no": emergencyNo,
    "email": email,
    "driving_no": drivingNo,
    "driving_date": drivingDate,
    "stnk_no": stnkNo,
    "stnk_date": stnkDate,
    "kk_no": kkNo,
    "maps": maps,
    "image_id": imageId,
    "image_npwp": imageNpwp,
    "image_kk": imageKk,
    "image_profile": imageProfile,
    "bank_name": bankName,
    "bank_no": bankNo,
    "bank_branch": bankBranch,
    "status": status,
    "status_date": statusDate,
  };
}

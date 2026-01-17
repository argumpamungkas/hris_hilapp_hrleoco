class User {
  String title;
  String message;
  String theme;
  ResultProfile results;

  User({
    required this.title,
    required this.message,
    required this.theme,
    required this.results,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        title: json["title"],
        message: json["message"],
        theme: json["theme"],
        results: ResultProfile.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "theme": theme,
        "results": results.toJson(),
      };
}

class ResultProfile {
  String? id;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;
  String? deleted;
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
  String? number;
  String? name;
  String? nickname;
  String? dateSign;
  String? dateExpired;
  String? address;
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
  String? maps;
  String? imageId;
  String? imageProfile;
  String? bankName;
  String? bankNo;
  String? bankBranch;
  String? status;
  String? statusDate;
  String? statusCheck;
  String? statusNotification;
  String? divisionName;
  String? departementName;
  String? departementSubName;
  String? type;
  String? positionName;
  String? contractName;
  String? access;
  String? service;
  String? linkFoto;

  ResultProfile({
    required this.id,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.deleted,
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
    required this.number,
    required this.name,
    required this.nickname,
    required this.dateSign,
    required this.dateExpired,
    required this.address,
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
    required this.maps,
    required this.imageId,
    required this.imageProfile,
    required this.bankName,
    required this.bankNo,
    required this.bankBranch,
    required this.status,
    required this.statusDate,
    required this.statusCheck,
    required this.statusNotification,
    required this.divisionName,
    required this.departementName,
    required this.departementSubName,
    required this.type,
    required this.positionName,
    required this.contractName,
    required this.access,
    required this.service,
    required this.linkFoto,
  });

  factory ResultProfile.fromJson(Map<String, dynamic> json) => ResultProfile(
        id: json["id"],
        createdBy: json["created_by"],
        createdDate: json["created_date"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
        deleted: json["deleted"],
        candidateId: json["candidate_id"],
        divisionId: json["division_id"],
        departementId: json["departement_id"],
        departementSubId: json["departement_sub_id"],
        contractId: json["contract_id"],
        positionId: json["position_id"],
        groupId: json["group_id"],
        sourceId: json["source_id"],
        maritalId: json["marital_id"],
        religionId: json["religion_id"],
        number: json["number"],
        name: json["name"],
        nickname: json["nickname"],
        dateSign: json["date_sign"],
        dateExpired: json["date_expired"],
        address: json["address"],
        placeBirth: json["place_birth"],
        birthday: json["birthday"],
        gender: json["gender"],
        blood: json["blood"],
        nationalId: json["national_id"],
        taxId: json["tax_id"],
        jamsostek: json["jamsostek"],
        jamsostekDate: json["jamsostek_date"],
        jkn: json["jkn"],
        jknDate: json["jkn_date"],
        jknFamily: json["jkn_family"],
        telphone: json["telphone"],
        mobilePhone: json["mobile_phone"],
        emergencyNo: json["emergency_no"],
        email: json["email"],
        drivingNo: json["driving_no"],
        drivingDate: json["driving_date"],
        stnkNo: json["stnk_no"],
        stnkDate: json["stnk_date"],
        maps: json["maps"],
        imageId: json["image_id"],
        imageProfile: json["image_profile"],
        bankName: json["bank_name"],
        bankNo: json["bank_no"],
        bankBranch: json["bank_branch"],
        status: json["status"],
        statusDate: json["status_date"],
        statusCheck: json["status_check"],
        statusNotification: json["status_notification"],
        divisionName: json["division_name"],
        departementName: json["departement_name"],
        departementSubName: json["departement_sub_name"],
        type: json["type"],
        positionName: json["position_name"],
        contractName: json["contract_name"],
        access: json["access"],
        service: json["service"],
        linkFoto: json["link_foto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
        "deleted": deleted,
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
        "number": number,
        "name": name,
        "nickname": nickname,
        "date_sign": dateSign,
        "date_expired": dateExpired,
        "address": address,
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
        "maps": maps,
        "image_id": imageId,
        "image_profile": imageProfile,
        "bank_name": bankName,
        "bank_no": bankNo,
        "bank_branch": bankBranch,
        "status": status,
        "status_date": statusDate,
        "status_check": statusCheck,
        "status_notification": statusNotification,
        "division_name": divisionName,
        "departement_name": departementName,
        "departement_sub_name": departementSubName,
        "type": type,
        "position_name": positionName,
        "contract_name": contractName,
        "access": access,
        "service": service,
        "link_foto": linkFoto,
      };
}

class UserChangeInPassword {
  String name;
  String username;
  String email;

  UserChangeInPassword({
    required this.name,
    required this.username,
    required this.email,
  });

  factory UserChangeInPassword.fromJson(Map<String, dynamic> json) =>
      UserChangeInPassword(
        name: json['name'],
        username: json['username'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
      };
}

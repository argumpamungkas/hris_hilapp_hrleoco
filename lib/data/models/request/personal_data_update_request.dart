class PersonalDataUpdateRequest {
  String number;
  String address;
  String domicile;
  String placeBirth;
  String birthday;
  String gender;
  String blood;
  String religionId;
  String maritalId;
  String nationalId;
  String kkNo;
  String taxId;
  String telphone;
  String mobilePhone;
  String emergencyNo;
  String email;
  String jknFamily;
  String drivingNo;
  String drivingDate;
  String stnkNo;
  String stnkDate;

  PersonalDataUpdateRequest({
    required this.number,
    required this.address,
    required this.domicile,
    required this.placeBirth,
    required this.birthday,
    required this.gender,
    required this.blood,
    required this.religionId,
    required this.maritalId,
    required this.nationalId,
    required this.taxId,
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
  });

  Map<String, String> toJson() => {
    "number": number,
    "address": address,
    "domicile": domicile,
    "place_birth": placeBirth,
    "birthday": birthday,
    "gender": gender,
    "blood": blood,
    "national_id": nationalId,
    "tax_id": taxId,
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
    // "maps": maps,
    // "image_id": imageId,
    // "image_npwp": imageNpwp,
    // "image_kk": imageKk,
    // "image_profile": imageProfile,
  };
}

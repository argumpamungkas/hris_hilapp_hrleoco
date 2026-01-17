class FamilyRequest {
  String number;
  String nationalId;
  String name;
  String place;
  String birthday;
  String relation;
  String profession;
  String contact;

  FamilyRequest({
    required this.number,
    required this.nationalId,
    required this.name,
    required this.place,
    required this.birthday,
    required this.relation,
    required this.profession,
    required this.contact,
  });

  Map<String, dynamic> toJson() => {
    "number": number,
    "national_id": nationalId,
    "name": name,
    "place": place,
    "birthday": birthday,
    "relation": relation,
    "profesion": profession,
    "contact": contact,
  };
}

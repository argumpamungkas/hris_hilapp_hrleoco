class CareerRequest {
  String number;
  String name;
  String description;
  String start;
  String profession;
  String contact;

  CareerRequest({
    required this.number,
    required this.name,
    required this.description,
    required this.start,
    required this.profession,
    required this.contact,
  });

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
    "description": description,
    "start": start,
    "profesion": profession,
    "contact": contact,
  };
}

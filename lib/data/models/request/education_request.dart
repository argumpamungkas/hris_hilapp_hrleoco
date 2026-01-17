class EducationRequest {
  String number;
  String educationLevel;
  String degree;
  String school;
  String start;
  String end;
  String qpa;

  EducationRequest({
    required this.number,
    required this.educationLevel,
    required this.degree,
    required this.school,
    required this.start,
    required this.end,
    required this.qpa,
  });

  Map<String, dynamic> toJson() => {
    "number": number,
    "level": educationLevel,
    "degree": degree,
    "school": school,
    "start": start,
    "end": end,
    "qpa": qpa,
  };
}

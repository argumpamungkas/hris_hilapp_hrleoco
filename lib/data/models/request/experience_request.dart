class ExperienceRequest {
  String number;
  String name;
  String type;
  String start;
  String end;
  String position;
  String salary;

  ExperienceRequest({
    required this.number,
    required this.name,
    required this.type,
    required this.start,
    required this.end,
    required this.position,
    required this.salary,
  });

  Map<String, dynamic> toJson() => {"number": number, "name": name, "type": type, "start": start, "end": end, "position": position, "salary": salary};
}

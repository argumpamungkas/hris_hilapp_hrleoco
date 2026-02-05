class ChangeDayRequest {
  String number;
  String start;
  String end;
  String remarks;

  ChangeDayRequest({required this.number, required this.start, required this.end, required this.remarks});

  Map<String, dynamic> toJson() => {"number": number, "start": start, "end": end, "remarks": remarks};
}

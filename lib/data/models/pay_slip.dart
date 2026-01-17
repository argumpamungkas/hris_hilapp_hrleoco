import 'package:intl/intl.dart';

import '../../ui/util/utils.dart';

class PaySlip {
  String title;
  String message;
  String theme;
  List<ResultsPaySlip> results;

  PaySlip({required this.title, required this.message, required this.theme, required this.results});

  factory PaySlip.fromJson(Map<String, dynamic> json) => PaySlip(
    title: json["title"],
    message: json["message"],
    theme: json["theme"],
    results: List<ResultsPaySlip>.from(json['results'].map((x) => ResultsPaySlip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "theme": theme,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class ResultsPaySlip {
  String? period;
  String? employeeNumber;
  String? employeeName;
  String? departement;
  String? departementSub;
  String? nationalId;
  String? taxId;
  String? marital;
  String? maritalName;
  String? terCode;
  String? workingDays;
  String? cutOff;
  int? basicSalary;
  int? allowanceFix;
  int? allowanceTemp;
  int? allowanceBpjs;
  int? overtimeHour;
  int? overtimeAmount;
  int? overtimeCorrectionHour;
  int? overtimeCorrectionAmount;
  int? correctionPlus;
  int? brutoIncome;
  int? absenceHour;
  int? absenceAmount;
  int? loans;
  int? correctionMinus;
  int? totalDeduction;
  int? income;
  List<BpjsEmployee> bpjsEmployee;
  int? totalBpjsEmployee;
  List<BpjsEmployee> bpjsCompany;
  int? totalBpjsCompany;
  int? ter;
  int? netIncome;

  ResultsPaySlip({
    required this.period,
    required this.employeeNumber,
    required this.employeeName,
    required this.departement,
    required this.departementSub,
    required this.nationalId,
    required this.taxId,
    required this.marital,
    required this.maritalName,
    required this.terCode,
    required this.workingDays,
    required this.cutOff,
    required this.basicSalary,
    required this.allowanceFix,
    required this.allowanceTemp,
    required this.allowanceBpjs,
    required this.overtimeHour,
    required this.overtimeAmount,
    required this.overtimeCorrectionHour,
    required this.overtimeCorrectionAmount,
    required this.correctionPlus,
    required this.brutoIncome,
    required this.absenceHour,
    required this.absenceAmount,
    required this.loans,
    required this.correctionMinus,
    required this.totalDeduction,
    required this.income,
    required this.bpjsEmployee,
    required this.totalBpjsEmployee,
    required this.bpjsCompany,
    required this.totalBpjsCompany,
    required this.ter,
    required this.netIncome,
  });

  factory ResultsPaySlip.fromJson(Map<String, dynamic> json) {
    late String periode;
    if (json['period'] != null || json['created_date'] != "") {
      var dateFormatDefautlt = DateFormat("yyyy-MM").parse(json['period']);
      periode = formatDatePeriod(dateFormatDefautlt);
    }
    return ResultsPaySlip(
      period: periode,
      cutOff: json["cutoff"],
      employeeNumber: json["employee_number"] ?? "-",
      employeeName: json["employee_name"] ?? "-",
      departement: json["departement"] ?? "-",
      departementSub: json["departement_sub"] ?? "-",
      nationalId: json["national_id"] ?? "-",
      taxId: json["tax_id"] ?? "-",
      marital: json["marital"] ?? "-",
      maritalName: json["marital_name"] ?? "-",
      terCode: json["ter_code"] ?? "-",
      workingDays: json["working_days"] ?? "0",
      basicSalary: json["basic_salary"] ?? 0,
      allowanceFix: json["allowance_fix"] ?? 0,
      allowanceTemp: json["allowance_temp"] ?? 0,
      allowanceBpjs: json["allowance_bpjs"] ?? 0,
      overtimeHour: json["overtime_hour"] ?? 0,
      overtimeAmount: json["overtime_amount"] ?? 0,
      overtimeCorrectionHour: json["overtime_correction_hour"] ?? 0,
      overtimeCorrectionAmount: json["overtime_correction_amount"] ?? 0,
      correctionPlus: json["correction_plus"] ?? 0,
      brutoIncome: json["bruto_income"] ?? 0,
      absenceHour: json["absence_hour"] ?? 0,
      absenceAmount: json["absence_amount"] ?? 0,
      loans: json["loans"] ?? 0,
      correctionMinus: json["correction_minus"] ?? 0,
      totalDeduction: json["total_deduction"] ?? 0,
      income: json["income"] ?? 0,
      bpjsEmployee: List<BpjsEmployee>.from(json["bpjs_employee"].map((x) => BpjsEmployee.fromJson(x))),
      totalBpjsEmployee: json["total_bpjs_employee"],
      bpjsCompany: List<BpjsEmployee>.from(json["bpjs_company"].map((x) => BpjsEmployee.fromJson(x))), // ngambil class sama karena key nya sama
      totalBpjsCompany: json["total_bpjs_company"] ?? 0,
      ter: json["ter"] ?? 0,
      netIncome: json["net_income"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "period": period,
    "employee_number": employeeNumber,
    "employee_name": employeeName,
    "departement": departement,
    "departement_sub": departementSub,
    "national_id": nationalId,
    "tax_id": taxId,
    "marital": marital,
    "marital_name": maritalName,
    "ter_code": terCode,
    "working_days": workingDays,
    "cutoff": cutOff,
    "basic_salary": basicSalary,
    "allowance_fix": allowanceFix,
    "allowance_temp": allowanceTemp,
    "allowance_bpjs": allowanceBpjs,
    "overtime_hour": overtimeHour,
    "overtime_amount": overtimeAmount,
    "overtime_correction_hour": overtimeCorrectionHour,
    "overtime_correction_amount": overtimeCorrectionAmount,
    "correction_plus": correctionPlus,
    "bruto_income": brutoIncome,
    "absence_hour": absenceHour,
    "absence_amount": absenceAmount,
    "loans": loans,
    "correction_minus": correctionMinus,
    "total_deduction": totalDeduction,
    "income": income,
    "bpjs_employee": List<dynamic>.from(bpjsEmployee.map((x) => x.toJson())),
    "total_bpjs_employee": totalBpjsEmployee,
    "bpjs_company": List<dynamic>.from(bpjsCompany.map((x) => x.toJson())),
    "total_bpjs_company": totalBpjsCompany,
    "ter": ter,
    "net_income": netIncome,
  };
}

class BpjsEmployee {
  String name;
  int? amount;

  BpjsEmployee({required this.name, required this.amount});

  factory BpjsEmployee.fromJson(Map<String, dynamic> json) => BpjsEmployee(name: json['name'], amount: json['amount'] ?? 0);

  Map<String, dynamic> toJson() => {"name": name, "amount": amount};
}

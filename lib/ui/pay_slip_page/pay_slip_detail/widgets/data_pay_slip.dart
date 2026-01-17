import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/pay_slip.dart';
import '../../../../providers/preferences_provider.dart';
import '../../../util/utils.dart';
import 'item_pay_slip_detail.dart';

class DataPaySlip extends StatelessWidget {
  const DataPaySlip({
    super.key,
    required this.resultsPaySlip,
  });

  final TextStyle _titleStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  final ResultsPaySlip resultsPaySlip;

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
    final TextStyle textStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const Text("SALARY SLIP"),
              Text(resultsPaySlip.period!, style: _titleStyle),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ItemPaySlipDetail(
          titleItem: "Cut Off Period",
          dataItem: resultsPaySlip.cutOff!,
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Employee ID",
          dataItem: resultsPaySlip.employeeNumber!,
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Employee Name",
          dataItem: resultsPaySlip.employeeName!,
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Departement",
          dataItem: resultsPaySlip.departement!,
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Departement Sub",
          dataItem: resultsPaySlip.departementSub!,
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "National ID",
          dataItem: resultsPaySlip.nationalId!,
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Tax ID",
          dataItem: resultsPaySlip.taxId!,
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Marital Status",
          dataItem:
              "(${resultsPaySlip.marital!}) ${resultsPaySlip.maritalName}",
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "TER Code",
          dataItem: resultsPaySlip.terCode!,
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Working Days",
          dataItem: "${resultsPaySlip.workingDays!} Days",
        ),
        const SizedBox(height: 16),
        Text("Income", style: _titleStyle),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Basic Salary",
          dataItem: formatRp(resultsPaySlip.basicSalary!),
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Allowence (Fix)",
          dataItem: formatRp(resultsPaySlip.allowanceFix!),
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Allowence (Temp)",
          dataItem: formatRp(resultsPaySlip.allowanceTemp!),
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Overtime",
          dataItem:
              "(${resultsPaySlip.overtimeHour} hours) ${formatRp(resultsPaySlip.overtimeAmount!)}",
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Correction Overtime",
          dataItem:
              "(${resultsPaySlip.overtimeCorrectionHour} hours) ${formatRp(resultsPaySlip.overtimeCorrectionAmount!)}",
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Correction Plus",
          dataItem: formatRp(resultsPaySlip.correctionPlus!),
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "TOTAL INCOME (a)",
          textStyle: textStyle,
          dataItem: formatRp(resultsPaySlip.income!),
        ),
        const SizedBox(height: 16),
        Text("BPJS Company", style: _titleStyle),
        const SizedBox(height: 8),
        ...resultsPaySlip.bpjsCompany
            .map(
              (bpjs) => Column(
                children: [
                  ItemPaySlipDetail(
                    titleItem: bpjs.name,
                    dataItem: formatRp(bpjs.amount!),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            )
            .toList(),
        ItemPaySlipDetail(
          titleItem: "TOTAL BPJS Company (b)",
          textStyle: textStyle,
          dataItem: formatRp(resultsPaySlip.totalBpjsCompany!),
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "BRUTO INCOME (c) = (a + b)",
          textStyle: textStyle,
          dataItem: formatRp(resultsPaySlip.brutoIncome!),
        ),
        const SizedBox(height: 16),
        Text("Deduction", style: _titleStyle),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Absence Hour",
          dataItem: resultsPaySlip.absenceHour.toString(),
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Absence Amount",
          dataItem: formatRp(resultsPaySlip.absenceAmount!),
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Loans",
          dataItem: resultsPaySlip.loans.toString(),
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Correction Minus",
          dataItem: resultsPaySlip.correctionMinus.toString(),
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "Allowence (BPJS)",
          dataItem: formatRp(resultsPaySlip.allowanceBpjs!),
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "TOTAL DEDUCTION (d)",
          textStyle: textStyle,
          dataItem: formatRp(resultsPaySlip.totalDeduction!),
        ),
        const SizedBox(height: 16),
        Text("BPJS Employee", style: _titleStyle),
        const SizedBox(height: 8),
        ...resultsPaySlip.bpjsEmployee
            .map(
              (bpjs) => Column(
                children: [
                  ItemPaySlipDetail(
                    titleItem: bpjs.name,
                    dataItem: formatRp(bpjs.amount!),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            )
            .toList(),
        ItemPaySlipDetail(
          titleItem: "TOTAL BPJS (e)",
          textStyle: textStyle,
          dataItem: formatRp(resultsPaySlip.totalBpjsEmployee!),
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "TER (f)",
          textStyle: textStyle,
          dataItem: formatRp(resultsPaySlip.ter!),
        ),
        const SizedBox(height: 8),
        ItemPaySlipDetail(
          titleItem: "NET INCOME (c - d - e - f)",
          textStyle: textStyle,
          dataItem: formatRp(resultsPaySlip.netIncome!),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../data/services/notification_services.dart';
import '../../../../data/models/pay_slip.dart';
import '../../../../main.dart';
import '../../../util/utils.dart';

class PaySlipDownloaded {
  final NotificationServices _NotificationServices = NotificationServices();

  Future<void> createPdf(BuildContext context, ResultsPaySlip resultsPaySlip) async {
    final pdf = pw.Document();

    var font = await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    var ttf = pw.Font.ttf(font);

    final pw.TextStyle titleStyle = pw.TextStyle(font: ttf, fontSize: 12, fontWeight: pw.FontWeight.bold);

    final pw.TextStyle totalTextStyle = pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: const PdfColor.fromInt(0xFF616161));

    final pw.TextStyle dataTextStyle = pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold, color: const PdfColor.fromInt(0xFF616161));

    pw.Widget itemSlip({required String titleItem, required String dataItem, pw.TextStyle? titleStyleTotal, pw.TextStyle? valueStyleTotal}) {
      return pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text(
                  titleItem,
                  style: titleStyleTotal ?? pw.TextStyle(font: ttf, color: const PdfColor.fromInt(0xFF616161), fontSize: 10),
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  dataItem,
                  textAlign: pw.TextAlign.end,
                  style:
                      valueStyleTotal ??
                      pw.TextStyle(font: ttf, color: const PdfColor.fromInt(0xFF616161), fontWeight: pw.FontWeight.bold, fontSize: 9),
                ),
              ),
            ],
          ),
          pw.Divider(thickness: 1, height: 4, color: const PdfColor.fromInt(0xFFE0E0E0)),
        ],
      );
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.legal,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Column(
                  children: [
                    pw.Text("SALARY SLIP", style: pw.TextStyle(font: ttf)),
                    pw.Text(resultsPaySlip.period!, style: titleStyle),
                  ],
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Flexible(
                    flex: 1,
                    child: pw.Column(
                      children: [
                        itemSlip(
                          titleItem: "Cut Off Period",
                          titleStyleTotal: dataTextStyle,
                          valueStyleTotal: dataTextStyle,
                          dataItem: resultsPaySlip.cutOff!,
                        ),
                        pw.SizedBox(height: 4),
                        itemSlip(
                          titleItem: "Employee ID",
                          titleStyleTotal: dataTextStyle,
                          valueStyleTotal: dataTextStyle,
                          dataItem: resultsPaySlip.employeeNumber!,
                        ),
                        pw.SizedBox(height: 4),
                        itemSlip(
                          titleItem: "Employee Name",
                          titleStyleTotal: dataTextStyle,
                          valueStyleTotal: dataTextStyle,
                          dataItem: resultsPaySlip.employeeName!,
                        ),
                        pw.SizedBox(height: 4),
                        itemSlip(
                          titleItem: "Departement",
                          titleStyleTotal: dataTextStyle,
                          valueStyleTotal: dataTextStyle,
                          dataItem: resultsPaySlip.departement!,
                        ),
                        pw.SizedBox(height: 4),
                        itemSlip(
                          titleItem: "Departement Sub",
                          titleStyleTotal: dataTextStyle,
                          valueStyleTotal: dataTextStyle,
                          dataItem: resultsPaySlip.departementSub!,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 20),
                  pw.Flexible(
                    flex: 1,
                    child: pw.Column(
                      children: [
                        itemSlip(
                          titleItem: "National ID",
                          titleStyleTotal: dataTextStyle,
                          valueStyleTotal: dataTextStyle,
                          dataItem: resultsPaySlip.nationalId!,
                        ),
                        pw.SizedBox(height: 4),
                        itemSlip(
                          titleItem: "Tax ID",
                          titleStyleTotal: dataTextStyle,
                          valueStyleTotal: dataTextStyle,
                          dataItem: resultsPaySlip.taxId!,
                        ),
                        pw.SizedBox(height: 4),
                        itemSlip(
                          titleItem: "Marital Status",
                          titleStyleTotal: dataTextStyle,
                          valueStyleTotal: dataTextStyle,
                          dataItem: "(${resultsPaySlip.marital!}) ${resultsPaySlip.maritalName}",
                        ),
                        pw.SizedBox(height: 4),
                        itemSlip(
                          titleItem: "TER Code",
                          titleStyleTotal: dataTextStyle,
                          valueStyleTotal: dataTextStyle,
                          dataItem: resultsPaySlip.terCode!,
                        ),
                        pw.SizedBox(height: 4),
                        itemSlip(
                          titleItem: "Working Days",
                          titleStyleTotal: dataTextStyle,
                          valueStyleTotal: dataTextStyle,
                          dataItem: "${resultsPaySlip.workingDays!} Days",
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // pw.SizedBox(height: 4),
              pw.SizedBox(height: 10),
              pw.Text("INCOME", style: titleStyle),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "Basic Salary", dataItem: formatRp(resultsPaySlip.basicSalary!)),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "Allowance (Fix)", dataItem: formatRp(resultsPaySlip.allowanceFix!)),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "Allowance (Temp)", dataItem: formatRp(resultsPaySlip.allowanceTemp!)),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "Overtime", dataItem: "(${resultsPaySlip.overtimeHour} hours) ${formatRp(resultsPaySlip.overtimeAmount!)}"),
              pw.SizedBox(height: 4),
              itemSlip(
                titleItem: "Correction Overtime",
                dataItem: "(${resultsPaySlip.overtimeCorrectionHour} hours) ${formatRp(resultsPaySlip.overtimeCorrectionAmount!)}",
              ),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "Correction Plus", dataItem: formatRp(resultsPaySlip.correctionPlus!)),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "TOTAL INCOME (a)", titleStyleTotal: totalTextStyle, dataItem: formatRp(resultsPaySlip.income!)),
              pw.SizedBox(height: 10),
              pw.Text("BPJS COMPANY", style: titleStyle),
              pw.SizedBox(height: 4),
              ...resultsPaySlip.bpjsCompany
                  .map(
                    (bpjs) => pw.Column(
                      children: [
                        itemSlip(titleItem: bpjs.name, dataItem: formatRp(bpjs.amount!)),
                        pw.SizedBox(height: 4),
                      ],
                    ),
                  )
                  .toList(),
              itemSlip(titleItem: "TOTAL BPJS COMPANY (b)", dataItem: formatRp(resultsPaySlip.totalBpjsCompany!)),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "BRUTO INCOME (c) = (a + b)", titleStyleTotal: totalTextStyle, dataItem: formatRp(resultsPaySlip.brutoIncome!)),
              pw.SizedBox(height: 10),
              pw.Text("DEDUCTION", style: titleStyle),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "Absence Hour", dataItem: resultsPaySlip.absenceHour.toString()),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "Absence Amount", dataItem: formatRp(resultsPaySlip.absenceAmount!)),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "Loans", dataItem: resultsPaySlip.loans.toString()),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "Correction Minus", dataItem: resultsPaySlip.correctionMinus.toString()),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "Allowance (BPJS)", dataItem: formatRp(resultsPaySlip.allowanceBpjs!)),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "TOTAL DEDUCTION (d)", dataItem: formatRp(resultsPaySlip.totalDeduction!)),
              pw.SizedBox(height: 10),
              pw.Text("BPJS EMPLOYEE", style: titleStyle),
              pw.SizedBox(height: 4),
              ...resultsPaySlip.bpjsEmployee
                  .map(
                    (bpjs) => pw.Column(
                      children: [
                        itemSlip(titleItem: bpjs.name, dataItem: formatRp(bpjs.amount!)),
                        pw.SizedBox(height: 4),
                      ],
                    ),
                  )
                  .toList(),
              itemSlip(titleItem: "TOTAL BPJS (e)", titleStyleTotal: totalTextStyle, dataItem: formatRp(resultsPaySlip.totalBpjsEmployee!)),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "TER (f)", titleStyleTotal: totalTextStyle, dataItem: formatRp(resultsPaySlip.ter!)),
              pw.SizedBox(height: 4),
              itemSlip(titleItem: "NET INCOME (c - d - e - f)", titleStyleTotal: totalTextStyle, dataItem: formatRp(resultsPaySlip.netIncome!)),
            ],
          );
        },
      ),
    );

    String localPath = '';

    if (Platform.isAndroid) {
      var infoDevice = await DeviceInfoPlugin().androidInfo;
      if (infoDevice.version.sdkInt > 28) {
        final directories = await getExternalStorageDirectories();
        // print("DIRECTORIES $directories");
        if (directories != null && directories.isNotEmpty) {
          localPath = directories.first.path;
        } else {
          localPath = '/storage/emulated/0/Download/';
          throw Exception("Could not find a valid downloads directory.");
        }
      } else {
        localPath = '/storage/emulated/0/Download/';
      }
    } else {
      var directory = await getApplicationDocumentsDirectory();
      localPath = '${directory.path}${Platform.pathSeparator}Download';
    }

    String fileName = "${resultsPaySlip.employeeNumber}_${resultsPaySlip.period}";
    File('$localPath/$fileName.pdf')
      ..createSync(recursive: true)
      ..writeAsBytesSync(await pdf.save(), flush: true);

    Future.delayed(const Duration(seconds: 1), () async {
      await _NotificationServices.showNotificationSuccessDownloading('$localPath/$fileName.pdf', "$fileName.pdf");

      if (!context.mounted) return;
      Navigator.pop(context);
    });
  }
}

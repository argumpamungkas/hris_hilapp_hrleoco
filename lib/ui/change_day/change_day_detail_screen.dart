import 'package:easy_hris/providers/change_days/change_days_provider.dart';
import 'package:easy_hris/ui/change_day/widgets/item_change_day_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../data/models/change_days.dart';
import '../util/utils.dart';

class ChangeDayDetailScreen extends StatelessWidget {
  static const routeName = "/change_day_detail_screen";

  ChangeDayDetailScreen({super.key, required this.resultsChangeDays});

  final ResultsChangeDays resultsChangeDays;
  late ChangeDaysProvider _changeDaysC;
  late String? dayFrom, replaceTo;

  void _convert() {
    if (resultsChangeDays.start != null) {
      var dateFormatDefautlt = DateFormat("yyyy-MM-dd").parse(resultsChangeDays.start!);
      dayFrom = formatCreated(dateFormatDefautlt);
    }

    if (resultsChangeDays.end != null) {
      var dateFormatDefautlt = DateFormat("yyyy-MM-dd").parse(resultsChangeDays.end!);
      replaceTo = formatCreated(dateFormatDefautlt);
    }
  }

  @override
  Widget build(BuildContext context) {
    _convert();
    _changeDaysC = Provider.of<ChangeDaysProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Days",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          ItemChangeDayDetail(titleItem: "Request ID", dataItem: resultsChangeDays.requestCode!),
          const SizedBox(height: 8),
          ItemChangeDayDetail(titleItem: "Day From", dataItem: resultsChangeDays.start != null ? dayFrom! : "-"),
          const SizedBox(height: 8),
          ItemChangeDayDetail(titleItem: "Replace To", dataItem: resultsChangeDays.end != null ? replaceTo! : "-"),
          const SizedBox(height: 8),
          ItemChangeDayDetail(
            titleItem: "Remarks",
            dataItem: resultsChangeDays.remarks != null || resultsChangeDays.remarks != "" ? resultsChangeDays.remarks! : "-",
          ),
          const SizedBox(height: 26),
          ElevatedButton(
            onPressed: resultsChangeDays.approvedTo == null || resultsChangeDays.approvedTo == ""
                ? null
                : () {
                    showConfirmDialog(
                      context,
                      titleConfirm: "Confirm",
                      descriptionConfirm: "Are you sure for cancel request?",
                      action: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                        TextButton(
                          onPressed: () async {
                            showLoadingDialog(context);
                            await Future.delayed(const Duration(seconds: 1)).then((value) async {
                              await _changeDaysC.cancelRequest(context, resultsChangeDays.id!).then((value) {
                                _changeDaysC.fetchChangeDays(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            });
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorBlueDark,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              minimumSize: const Size.fromHeight(46),
            ),
            child: const Text("Cancel Request"),
          ),
        ],
      ),
    );
  }
}

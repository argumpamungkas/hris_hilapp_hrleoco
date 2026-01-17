import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/change_days.dart';
import '../change_day_detail_screen.dart';
import '../../util/utils.dart';

class ItemChangeDays extends StatelessWidget {
  const ItemChangeDays({super.key, required this.resultsChangeDays});

  final ResultsChangeDays resultsChangeDays;

  @override
  Widget build(BuildContext context) {
    late String? start;
    if (resultsChangeDays.start != null) {
      var dateFormatDefautlt = DateFormat("yyyy-MM-dd").parse(resultsChangeDays.start!);
      start = formatDateWithNameMonth(dateFormatDefautlt);
    }

    return ListTile(
      onTap: () => Navigator.pushNamed(context, ChangeDayDetailScreen.routeName, arguments: resultsChangeDays),
      title: Text(resultsChangeDays.start != null ? start! : "-", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      subtitle: Text(resultsChangeDays.requestCode != null ? resultsChangeDays.requestCode!.trim() : "-", style: const TextStyle(fontSize: 11)),
      trailing: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: resultsChangeDays.approvedTo == null || resultsChangeDays.approvedTo == "" ? Colors.green.shade300 : Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          resultsChangeDays.approvedTo == null || resultsChangeDays.approvedTo == "" ? "Approved" : "Checking",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }
}

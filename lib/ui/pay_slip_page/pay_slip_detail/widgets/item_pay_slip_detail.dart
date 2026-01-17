import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/preferences_provider.dart';

class ItemPaySlipDetail extends StatelessWidget {
  const ItemPaySlipDetail({super.key, required this.titleItem, required this.dataItem, this.textStyle});

  final String titleItem, dataItem;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(titleItem, style: textStyle ?? TextStyle(color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700, fontSize: 11)),
            ),
            Expanded(
              child: Text(
                dataItem,
                textAlign: TextAlign.end,
                style: TextStyle(color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700, fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Divider(thickness: 1, height: 0, color: Colors.grey.shade300),
      ],
    );
  }
}

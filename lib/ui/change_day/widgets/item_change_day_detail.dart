import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/preferences_provider.dart';

class ItemChangeDayDetail extends StatelessWidget {
  const ItemChangeDayDetail({
    super.key,
    required this.titleItem,
    required this.dataItem,
  });

  final String titleItem, dataItem;

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                titleItem,
                style: TextStyle(
                  color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                dataItem,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: prov.isDarkTheme ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Divider(
          thickness: 1,
          height: 0,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}

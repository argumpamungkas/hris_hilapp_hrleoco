import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../providers/preferences_provider.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Shimmer.fromColors(
          baseColor: prov.isDarkTheme ? Colors.black38 : Colors.grey.shade300,
          highlightColor: prov.isDarkTheme ? Colors.black : Colors.white,
          child: Card(
            color: prov.isDarkTheme ? Colors.black : Colors.white,
            child: Container(
              height: 80,
            ),
          ),
        );
      }
    );
  }
}

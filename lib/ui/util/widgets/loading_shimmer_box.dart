import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../providers/preferences_provider.dart';

class LoadingShimmerBox extends StatelessWidget {
  const LoadingShimmerBox({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
    return Shimmer.fromColors(
      baseColor: prov.isDarkTheme ? Colors.black38 : Colors.grey.shade300,
      highlightColor: prov.isDarkTheme ? Colors.black : Colors.white,
      child: Card(
        color: prov.isDarkTheme ? Colors.black : Colors.white,
        child: Container(height: height),
      ),
    );
  }
}

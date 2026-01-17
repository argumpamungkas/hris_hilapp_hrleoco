import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/preferences_provider.dart';
import '../util/widgets/app_bar_custom.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, title: "Settings", leadingBack: true),
      body: Consumer<PreferencesProvider>(
        builder: (context, prov, _) {
          return ListView(
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                title: const Text("Dark Theme"),
                value: prov.isDarkTheme,
                onChanged: (value) => prov.enableDarkTheme(),
              ),
            ],
          );
        },
      ),
    );
  }
}

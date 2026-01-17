import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/home/widgets/menu_home.dart';
import 'package:easy_hris/ui/home/widgets/user_widget.dart';
import 'package:flutter/material.dart';

import '../../../constant/constant.dart';

class ContainerUserAction extends StatelessWidget {
  const ContainerUserAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provPref, _) {
        return Card(
          color: provPref.isDarkTheme ? Colors.black : Colors.white,
          surfaceTintColor: provPref.isDarkTheme ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
          ),
          child: Column(
            children: [
              UserWidget(),
              Divider(height: 0, thickness: 1, color: provPref.isDarkTheme ? colorBlueDark : Colors.grey.shade300),
              MenuHome(),
            ],
          ),
        );
      },
    );
  }
}

import 'package:easy_hris/ui/change_day/widgets/form_change_day_adding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/constant.dart';
import '../../providers/preferences_provider.dart';
import '../util/widgets/form_container.dart';

class ChangeDayAddingScreen extends StatelessWidget {
  static const routeName = "/change_day_adding_screen";

  const ChangeDayAddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prov = Provider.of<PreferencesProvider>(context);
    return Scaffold(
      backgroundColor: prov.isDarkTheme ? Theme.of(context).scaffoldBackgroundColor : colorPurpleAccent,
      appBar: AppBar(
        backgroundColor: prov.isDarkTheme ? Theme.of(context).scaffoldBackgroundColor : colorPurpleAccent,
        foregroundColor: Colors.white,
        title: const Text(
          "Add Change Day",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: const SingleChildScrollView(
        child: FormContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Please Complete your input Change Day", softWrap: true), SizedBox(height: 16), FormChangeDayAdding()],
          ),
        ),
      ),
    );
  }
}

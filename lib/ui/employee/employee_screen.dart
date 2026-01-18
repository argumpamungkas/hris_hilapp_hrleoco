import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/data/models/response/employee_response_model.dart';
import 'package:easy_hris/providers/employee/employee_provider.dart';
import 'package:easy_hris/ui/employee/screen/career_employee_screen.dart';
import 'package:easy_hris/ui/employee/screen/company_employee_screen.dart';
import 'package:easy_hris/ui/employee/screen/education_employee_screen.dart';
import 'package:easy_hris/ui/employee/screen/experience_employee_screen.dart';
import 'package:easy_hris/ui/employee/screen/family_employee_screen.dart';
import 'package:easy_hris/ui/employee/screen/personal_employee_screen.dart';
import 'package:easy_hris/ui/employee/screen/training_employee_screen.dart';
import 'package:easy_hris/ui/employee/widgets/tab_custom.dart';
import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  Widget _getTabScreen(int index, EmployeeResponseModel employee) {
    switch (index) {
      case 0:
        return CompanyEmployeeScreen(employee: employee);
      case 1:
        return PersonalScreen(employee: employee);
      case 2:
        return FamilyEmployeeScreen();
      case 3:
        return EducationEmployeeScreen();
      case 4:
        return ExperienceEmployeeScreen();
      case 5:
        return TrainingEmployeeScreen();
      case 6:
        return CareerEmployeeScreen();
      default:
        return Center(child: Text("Page not found"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmployeeProvider(),
      child: Scaffold(
        appBar: appBarCustom(context, title: "Employee", leadingBack: true),
        body: Consumer<EmployeeProvider>(
          builder: (context, prov, _) {
            switch (prov.resultStatus) {
              case ResultStatus.loading:
                return Center(child: CupertinoActivityIndicator());
              case ResultStatus.error:
                return Center(child: Text(prov.message));
              case ResultStatus.noData:
                return Center(child: Text(prov.message));
              case ResultStatus.hasData:
                return SafeArea(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: prov.tabs.asMap().entries.map((entry) {
                            final index = entry.key;
                            final value = entry.value;

                            return TabCustom(
                              isNowTab: index == prov.index,
                              title: value,
                              onTap: () {
                                prov.onChangeTabs(index);
                              },
                            );
                          }).toList(),
                        ),
                      ),

                      Expanded(child: _getTabScreen(prov.index, prov.employeeResponseModel!)),
                    ],
                  ),
                );
              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

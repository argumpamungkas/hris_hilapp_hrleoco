import 'package:easy_hris/providers/employee/employee_provider.dart';
import 'package:easy_hris/ui/profile/widgets/item_data_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../constant/routes.dart';
import '../../../data/models/employee_response_model.dart';
import '../../util/utils.dart';
import '../../util/widgets/dialog_helpers.dart';
import '../widgets/header_employee_action.dart';

class EducationEmployeeScreen extends StatelessWidget {
  const EducationEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Consumer<EmployeeProvider>(
                builder: (context, prov, _) {
                  return HeaderEmployeeAction(
                    title: "Education Information",
                    onTap: () {
                      Navigator.pushNamed(context, Routes.addEducationScreen).then((value) {
                        prov.fetchEmployee();
                      });
                    },
                  );
                },
              ),

              Divider(),

              Expanded(
                child: Consumer<EmployeeProvider>(
                  builder: (context, prov, _) {
                    if (prov.employeeResponseModel!.employeeEducations.isEmpty) {
                      return Center(child: Text("Data Education is Empty"));
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        prov.fetchEmployee();
                      },
                      child: ListView.builder(
                        itemCount: prov.employeeResponseModel!.employeeEducations.length,
                        itemBuilder: (context, index) {
                          final employee = prov.employeeResponseModel!.employeeEducations[index];
                          return Card(
                            child: ExpansionTile(
                              shape: const Border(), // saat expanded
                              collapsedShape: const Border(), // saat collapsed
                              tilePadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                              leading: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(shape: BoxShape.circle, color: colorPurpleAccent),
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                              title: Text("${employee.degree} - ${employee.school}"),
                              childrenPadding: EdgeInsets.symmetric(horizontal: 8.w),
                              children: [
                                Divider(),
                                ItemDataUser(title: "Educational Level", value: employee.level ?? "-"),
                                ItemDataUser(title: "Degree", value: employee.degree ?? "-"),
                                ItemDataUser(title: "School/University", value: employee.school ?? "-"),
                                ItemDataUser(title: "Start", value: employee.start ?? "-"),
                                ItemDataUser(title: "End", value: employee.end ?? "-"),
                                ItemDataUser(title: "QPA", value: employee.qpa ?? "-"),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    showConfirmDialog(
                                      context,
                                      titleConfirm: "Confirm",
                                      descriptionConfirm: "Are you sure remove data ${employee.degree} - ${employee.school} ?",
                                      action: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            showLoadingDialog(context);

                                            final result = await prov.deleteEmployee(employee.id!, "deleteEducation");

                                            if (!context.mounted) return;
                                            Navigator.pop(context);
                                            if (result) {
                                              DialogHelper.showInfoDialog(
                                                context,
                                                icon: Icon(Icons.check, size: 32, color: Colors.green),
                                                title: prov.title,
                                                message: prov.message,
                                                onPressed: () {
                                                  prov.fetchEmployee();
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                              );
                                            } else {
                                              DialogHelper.showInfoDialog(
                                                context,
                                                icon: Icon(Icons.close_rounded, size: 32, color: Colors.red.shade700),
                                                title: prov.title,
                                                message: prov.message,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              );
                                            }
                                          },
                                          child: Text("Yes"),
                                        ),
                                      ],
                                    );
                                  },
                                  label: Text("Remove"),
                                  icon: Icon(Icons.delete_outline),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700, foregroundColor: Colors.white),
                                ),
                                SizedBox(height: 8.h),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

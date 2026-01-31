import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/constant/routes.dart';
import 'package:easy_hris/data/models/response/employee_response_model.dart';
import 'package:easy_hris/providers/employee/employee_provider.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/employee/widgets/header_employee_action.dart';
import 'package:easy_hris/ui/profile/widgets/item_data_user.dart';
import 'package:easy_hris/ui/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';
import '../../util/widgets/dialog_helpers.dart';
import '../../util/widgets/card_info_custom.dart';

class FamilyEmployeeScreen extends StatelessWidget {
  const FamilyEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Consumer2<EmployeeProvider, PreferencesProvider>(
                builder: (context, prov, provPref, _) {
                  return Column(
                    children: [
                      HeaderEmployeeAction(
                        title: "Family Information",
                        isUpdate: provPref.isUpdatePersonalData,
                        onTap: () {
                          Navigator.pushNamed(context, Routes.addFamilyScreen).then((value) {
                            prov.fetchEmployee();
                          });
                        },
                      ),
                      Divider(),

                      !provPref.isUpdatePersonalData
                          ? Column(
                              children: [
                                CardInfoCustom(value: "Not yet entered the Personal Data update period."),
                                SizedBox(height: 12.h),
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  );
                },
              ),

              Expanded(
                child: Consumer2<EmployeeProvider, PreferencesProvider>(
                  builder: (context, prov, provPref, _) {
                    if (prov.employeeResponseModel!.employeeFamilies.isEmpty) {
                      return Center(child: Text("Data Family is Empty"));
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        prov.fetchEmployee();
                      },
                      child: ListView.builder(
                        itemCount: prov.employeeResponseModel!.employeeFamilies.length,
                        itemBuilder: (context, index) {
                          final employee = prov.employeeResponseModel!.employeeFamilies[index];
                          return Card(
                            child: ExpansionTile(
                              shape: const Border(), // saat expanded
                              collapsedShape: const Border(), // saat collapsed
                              tilePadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                              leading: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(shape: BoxShape.circle, color: ConstantColor.colorBlue),
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                              title: Text("${employee.name} - ${employee.relation}"),
                              childrenPadding: EdgeInsets.symmetric(horizontal: 8.w),
                              children: [
                                Divider(),
                                ItemDataUser(title: "National ID", value: employee.nationalId ?? "-"),
                                ItemDataUser(title: "Family Name", value: employee.name ?? "-"),
                                ItemDataUser(title: "Place of Birth", value: employee.place ?? "-"),
                                ItemDataUser(title: "Birthday", value: employee.birthday ?? "-"),
                                ItemDataUser(title: "Relation", value: employee.relation ?? "-"),
                                ItemDataUser(title: "Profesion", value: employee.profesion ?? "-"),
                                ItemDataUser(title: "Contact", value: employee.contact ?? "-"),
                                Visibility(
                                  visible: provPref.isUpdatePersonalData ? true : false,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      showConfirmDialog(
                                        context,
                                        titleConfirm: "Confirm",
                                        descriptionConfirm: "Are you sure remove data ${employee.name} - ${employee.relation} ?",
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

                                              final result = await prov.deleteData(employee.id, "deleteFamily");

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

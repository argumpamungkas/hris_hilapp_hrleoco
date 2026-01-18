import 'package:easy_hris/data/models/response/employee_response_model.dart';
import 'package:easy_hris/ui/util/widgets/card_custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyEmployeeScreen extends StatelessWidget {
  const CompanyEmployeeScreen({super.key, required this.employee});

  final EmployeeResponseModel employee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Text(
                "Company Information".toUpperCase(),
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            CardCustomIcon(title: "Employee ID", subtitle: employee.employee?.number ?? "-", iconData: Icons.credit_card),
            CardCustomIcon(title: "Employee Name", subtitle: employee.employee?.name ?? "-", iconData: Icons.person_2_outlined),
            CardCustomIcon(title: "Division", subtitle: employee.division?.name ?? "-", iconData: Icons.business_sharp),
            CardCustomIcon(title: "Departement", subtitle: employee.departement?.name ?? "-", iconData: Icons.business_sharp),
            CardCustomIcon(title: "Departement Sub", subtitle: employee.departementSub?.name ?? "-", iconData: Icons.business_sharp),
            CardCustomIcon(title: "Employee Type", subtitle: employee.contract?.name ?? "-", iconData: Icons.file_copy_outlined),
            CardCustomIcon(title: "Position", subtitle: employee.position?.name ?? "-", iconData: Icons.file_copy_outlined),
            CardCustomIcon(title: "Group", subtitle: employee.group?.name ?? "-", iconData: Icons.people_outline),
            CardCustomIcon(title: "Source", subtitle: employee.source ?? "-", iconData: Icons.source_outlined),
            CardCustomIcon(title: "Join Date", subtitle: employee.employee?.dateSign ?? "-", iconData: Icons.calendar_today),
            CardCustomIcon(title: "Fit of Service", subtitle: employee.service ?? "-", iconData: Icons.calendar_month),
          ],
        ),
      ),
    );
  }
}

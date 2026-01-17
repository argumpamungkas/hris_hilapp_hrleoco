import 'package:easy_hris/constant/constant.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/personal_data_provider.dart';
import 'package:easy_hris/ui/profile/widgets/item_data_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/widgets/app_bar_custom.dart';

class ProfilePersonalDataScreen extends StatelessWidget {
  const ProfilePersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PersonalDataProvider(),
      child: Scaffold(
        appBar: appBarCustom(context, title: "Personal Data", leadingBack: true),
        body: Consumer<PersonalDataProvider>(
          builder: (context, prov, _) {
            if (prov.resultStatus == ResultStatus.loading) {
              return Center(child: CupertinoActivityIndicator());
            }

            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ItemDataUser(title: "Address", value: prov.employee?.address ?? ""),
                  ItemDataUser(title: "Domicile", value: prov.employee?.domicile ?? ""),
                  ItemDataUser(title: "Place of Birth", value: prov.employee?.placeBirth ?? ""),
                  ItemDataUser(title: "Birth Date", value: prov.employee?.birthday ?? ""),
                  ItemDataUser(title: "Gender", value: prov.selectedGender != null ? prov.selectedGender!.name : ""),
                  ItemDataUser(title: "Blood Type", value: prov.selectedBlood != null ? prov.selectedBlood!.name : ""),
                  ItemDataUser(title: "Religion", value: prov.selectedReligion != null ? prov.selectedReligion!.name! : ""),
                  ItemDataUser(title: "Marital Status", value: prov.selectedMarital != null ? prov.selectedMarital!.name! : ""),
                  ItemDataUser(
                    title: "National ID (KTP)",
                    value: prov.employee?.nationalId ?? "",
                    filePhoto: prov.fileNationalIdFIle,
                    hasPhoto: true,
                  ),
                  ItemDataUser(title: "Family Card (KK)", value: prov.employee?.kkNo ?? "", filePhoto: prov.fileFamilyCard, hasPhoto: true),
                  ItemDataUser(title: "Tax No (NPWP)", value: prov.employee?.taxId ?? "", filePhoto: prov.fileTaxNoNPWP, hasPhoto: true),
                  ItemDataUser(title: "Telephone No", value: prov.employee?.telphone ?? ""),
                  ItemDataUser(title: "Phone No", value: prov.employee?.mobilePhone ?? ""),
                  ItemDataUser(title: "Emergeny No", value: prov.employee?.emergencyNo ?? ""),
                  ItemDataUser(title: "Email", value: prov.employee?.email ?? ""),
                  ItemDataUser(title: "Number of Family", value: prov.employee?.jknFamily ?? ""),
                  ItemDataUser(title: "BPJS TK", value: prov.employee?.jamsostek ?? ""),
                  ItemDataUser(title: "JKN", value: prov.employee?.jkn ?? ""),
                  ItemDataUser(title: "Driving License", value: prov.employee?.drivingNo ?? ""),
                  ItemDataUser(title: "STNK No", value: prov.employee?.stnkNo ?? ""),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

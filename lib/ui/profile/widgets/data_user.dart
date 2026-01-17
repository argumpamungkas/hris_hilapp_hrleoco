import 'package:flutter/material.dart';

import 'item_data_user.dart';

// untuk test
class DataUser extends StatelessWidget {
  const DataUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemDataUser(title: "Email", value: "agungsaputro2451@gmail.com"),
        ItemDataUser(title: "Phone No", value: "6285129519202"),
        ItemDataUser(title: "Division", value: "PT ASKARA INTERNAL"),
        ItemDataUser(title: "Departement", value: "TECHNICAL"),
        ItemDataUser(title: "Departement Sub", value: "MAINTENANCE"),
        ItemDataUser(title: "Employee Type", value: "PERMANENT"),
        ItemDataUser(title: "Group", value: "GOLONGAN I"),
        ItemDataUser(title: "Sign Date", value: "04 Februari 2004"),
        ItemDataUser(title: "Contract Expired", value: "-"),
        ItemDataUser(title: "Address", value: "Kp Sukaluyu 01/31, Jatimulya"),
        ItemDataUser(title: "Place of Birth", value: "JAKARTA"),
        ItemDataUser(title: "Birthday", value: "15 November 1956"),
        ItemDataUser(title: "Gender", value: "MALE"),
        ItemDataUser(title: "Blood Tyoe", value: "A"),
        ItemDataUser(title: "Religion", value: "ISLAM"),
        ItemDataUser(title: "Marital Status", value: "KAWIN 2 TANGGUNGAN"),
        ItemDataUser(title: "National ID", value: "324159129591924"),
        ItemDataUser(title: "Tax ID", value: "19591258192671822"),
        ItemDataUser(title: "BPJS TK", value: "20088852015"),
        ItemDataUser(title: "BPJS KES", value: "0001404026155"),
      ],
    );
  }
}

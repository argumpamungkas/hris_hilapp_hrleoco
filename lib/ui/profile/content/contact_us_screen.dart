import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/preferences_provider.dart';
import 'package:easy_hris/ui/util/widgets/item_detail_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prov, _) {
        return Expanded(
          child: Column(
            spacing: 4.h,
            mainAxisSize: MainAxisSize.min,
            children: [
              ItemDetailTransaction(title: "Number", value: prov.configModel!.number!),
              ItemDetailTransaction(title: "Name", value: prov.configModel!.name!),
              ItemDetailTransaction(title: "Description", value: prov.configModel!.description!),
              ItemDetailTransaction(title: "Address", value: prov.configModel!.address!),
              ItemDetailTransaction(title: "City", value: prov.configModel!.city!),
              ItemDetailTransaction(title: "Postal Code", value: prov.configModel!.postalCode ?? ''),
              ItemDetailTransaction(title: "Telephone", value: prov.configModel!.telp ?? ''),
              ItemDetailTransaction(title: "Fax", value: prov.configModel!.fax ?? ''),
              ItemDetailTransaction(title: "Email", value: prov.configModel!.email ?? ''),
              ItemDetailTransaction(title: "Website", value: prov.configModel!.website ?? ''),
            ],
          ),
        );
      },
    );
  }
}

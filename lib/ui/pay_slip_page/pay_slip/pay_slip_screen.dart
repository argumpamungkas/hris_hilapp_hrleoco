import 'package:easy_hris/providers/payslip/payslip_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/constant.dart';
import '../../../data/models/pay_slip.dart';
import '../../util/widgets/data_not_found.dart';
import '../../util/widgets/shimmer_list_load_data.dart';
import 'widgets/item_pay_slip.dart';

class PaySlipScreen extends StatefulWidget {
  static const routeName = "/pay_slip_screen";

  const PaySlipScreen({super.key});

  @override
  State<PaySlipScreen> createState() => _PaySlipScreenState();
}

class _PaySlipScreenState extends State<PaySlipScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PayslipProvider>(context, listen: false).fetchPaySlip(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pay Slip",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Consumer<PayslipProvider>(
        builder: (context, prov, child) {
          switch (prov.resultStatus) {
            case ResultStatus.loading:
              return const ShimmerListLoadData();
            case ResultStatus.noData:
              return const DataEmpty(dataName: "Pay Slip");
            case ResultStatus.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(prov.message),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        prov.fetchPaySlip(context);
                      },
                      child: const Text("Refresh"),
                    ),
                  ],
                ),
              );
            case ResultStatus.hasData:
              return ListView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: prov.listPaySlip.length,
                itemBuilder: (context, index) {
                  ResultsPaySlip paySlip = prov.listPaySlip[index];
                  return Column(
                    children: [
                      ItemPaySlip(paySlip: paySlip),
                      Divider(thickness: 1, height: 0, color: Colors.grey.shade300),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}

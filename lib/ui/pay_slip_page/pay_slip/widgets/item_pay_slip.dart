import 'package:flutter/material.dart';

import '../../../../data/models/pay_slip.dart';
import '../../pay_slip_detail/pay_slip_detail_screen.dart';

class ItemPaySlip extends StatelessWidget {
  const ItemPaySlip({
    super.key,
    required this.paySlip,
  });

  final ResultsPaySlip paySlip;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      onTap: () => Navigator.pushNamed(
        context,
        PaySlipDetailScreen.routeName,
        arguments: paySlip,
      ),
      title: Text(paySlip.period!),
      trailing: const Icon(
        Icons.arrow_forward_ios_outlined,
        color: Colors.grey,
      ),
    );
  }
}

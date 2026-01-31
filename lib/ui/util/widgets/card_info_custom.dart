import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardInfoCustom extends StatelessWidget {
  const CardInfoCustom({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(12.w)),
        padding: EdgeInsets.all(16.w),
        child: Row(
          spacing: 8.w,
          children: [
            Icon(Icons.info),
            Expanded(child: Text(value)),
          ],
        ),
      ),
    );
  }
}

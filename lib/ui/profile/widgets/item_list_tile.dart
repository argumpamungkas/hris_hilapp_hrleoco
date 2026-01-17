import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({
    super.key,
    required this.iconLeading,
    required this.title,
    required this.onTap,
  });

  final IconData iconLeading;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 4.h,
        ),
        onTap: onTap,
        leading: Icon(iconLeading),
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

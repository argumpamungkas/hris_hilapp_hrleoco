import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant/constant.dart';
import '../../../constant/routes.dart';

class ItemTeam extends StatelessWidget {
  const ItemTeam({
    super.key,
    required this.name,
    required this.telp,
    required this.yearsWork,
    required this.imgUrl,
    required this.employeeId,
    required this.dateSign,
  });

  final String name;
  final String telp;
  final String yearsWork;
  final String imgUrl;
  final String employeeId;
  final String dateSign;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            onTap: () async {
              // if (telp == ''){
              //   showFailSnackbar(context, "Number is Empty");
              //   return;
              // }
              // try {
              //   await launchUrl(Uri.parse("tel://$telp"));
              // } catch (e) {
              //   if (!context.mounted) return;
              //   showFailSnackbar(context, "Failed to redirect");
              // }

              Navigator.pushNamed(
                context,
                Routes.teamsDetailScreen,
                arguments: {"employeeId": employeeId, "name": name, "imageUrl": imgUrl, "yearsWork": yearsWork, "dateSign": dateSign},
              );
            },
            leading: Container(
              width: 42.w,
              height: 42.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover, filterQuality: FilterQuality.medium),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            title: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(telp == '' ? '-' : telp, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(color: colorPurpleAccent, borderRadius: BorderRadius.circular(50)),
              child: Text(
                yearsWork,
                style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

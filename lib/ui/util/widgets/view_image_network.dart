import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_hris/constant/exports.dart';
import 'package:easy_hris/providers/profiles/view_image_network_provider.dart';
import 'package:easy_hris/ui/util/utils.dart';
import 'package:easy_hris/ui/util/widgets/app_bar_custom.dart';
import 'package:easy_hris/ui/util/widgets/dialog_helpers.dart';
import 'package:easy_hris/ui/util/widgets/image_network_custom.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ViewImageNetwork extends StatelessWidget {
  const ViewImageNetwork({super.key, required this.selectImage});

  final String selectImage;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ViewImageNetworkProvider(),
      child: Scaffold(
        appBar: AppbarCustom.appbar(
          context,
          title: "",
          leadingBack: true,
          action: [
            Consumer<ViewImageNetworkProvider>(
              builder: (context, prov, _) {
                return IconButton(
                  onPressed: () {
                    showInfoSnackbar(context, "Downloading on progress....");
                    prov.prepareSaveDir(selectImage);
                  },
                  icon: Icon(Icons.download),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: InteractiveViewer(
            maxScale: 5,
            child: Hero(
              tag: selectImage,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: ImageNetworkCustom(url: selectImage),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

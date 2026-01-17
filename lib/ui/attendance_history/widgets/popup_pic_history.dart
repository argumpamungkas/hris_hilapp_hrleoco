import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PopupPicHistory extends StatelessWidget {
  const PopupPicHistory({
    super.key,
    required this.link,
    required this.fotoIn,
    required this.fotoOut,
  });

  final String link;
  final String? fotoIn, fotoOut;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "History",
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                fotoIn != null
                    ? _showPicture(imgUrl: "$link$fotoIn")
                    : _pictureNull(),
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade50,
                  ),
                  child: Text(
                    "In",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                fotoOut != null
                    ? _showPicture(imgUrl: "$link$fotoOut")
                    : _pictureNull(),
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.shade50,
                  ),
                  child: Text(
                    "Out",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _showPicture({required String imgUrl}) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: CachedNetworkImage(
        progressIndicatorBuilder: (context, url, progress) => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ),
        imageUrl: imgUrl,
        errorWidget: (context, url, error) => const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("404"),
            Text(
              "Picture is Not Found",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Container _pictureNull() {
    return Container(
      alignment: Alignment.center,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
      ),
      child: const Text(
        "You haven't been attendance",
        textAlign: TextAlign.center,
        softWrap: true,
      ),
    );
  }
}

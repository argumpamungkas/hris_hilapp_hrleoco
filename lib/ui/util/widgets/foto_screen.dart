import 'package:flutter/material.dart';

class FotoScreen extends StatelessWidget {
  static const routeName = "/foto_screen";

  const FotoScreen({super.key, required this.imgUrl});

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: imgUrl,
                child: Image.network(
                  imgUrl,
                  height: MediaQuery.of(context).size.height * 0.7,
                ),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  String image;
  ImageView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "ImageView",
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: InteractiveViewer(
                clipBehavior: Clip.none,
                minScale: 1,
                maxScale: 3,
                child: Image.network(image))),
      ),
    );
  }
}

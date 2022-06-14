// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/features/doubts/display/providers/imagePickerProvider.dart';

pickedImageWidget(context, XFile? pickedImage) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 100),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: (pickedImage == null)
          ? Container()
          : Stack(
              children: [
                Card(
                  color: Colors.green[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(pickedImage.path),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Provider.of<ImagePickerProvider>(context, listen: false)
                          .removePickedImage();
                    },
                    icon: const Icon(
                      Icons.dangerous_outlined,
                      size: 40,
                    )),
              ],
            ),
    ),
  );
}

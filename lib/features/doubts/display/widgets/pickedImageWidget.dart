// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/features/doubts/display/providers/imagePickerProvider.dart';

pickedImageWidget(context, XFile? pickedImage, String subject) {
  bool uploading = Provider.of<ImagePickerProvider>(context).uploading;
  return Align(
    alignment: Alignment.bottomCenter,
    child: (pickedImage == null)
        ? Container()
        : (uploading)
            ? const Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: const Color.fromARGB(255, 157, 192, 160),
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
                            Provider.of<ImagePickerProvider>(context,
                                    listen: false)
                                .changeUploadingStatus(true);
                            Provider.of<ImagePickerProvider>(context,
                                    listen: false)
                                .uploadImage(
                                    pickedImage, subject, "username+phone");
                          },
                          icon: const Icon(
                            Icons.send,
                            size: 40,
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: IconButton(
                        onPressed: () {
                          Provider.of<ImagePickerProvider>(context,
                                  listen: false)
                              .removePickedImage();
                        },
                        icon: const Icon(
                          Icons.highlight_remove_sharp,
                          size: 40,
                          color: Colors.redAccent,
                        )),
                  ),
                ],
              ),
  );
}

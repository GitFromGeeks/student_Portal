// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/features/doubts/data/datasources/doubtsDB.dart';
import 'package:student_portal/features/doubts/display/providers/imagePickerProvider.dart';

messageBox(
  context,
  TextEditingController message,
  String subject,
  XFile? image,
) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      color: Colors.grey[300],
      child: ListTile(
          leading: FittedBox(
            fit: BoxFit.fill,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Provider.of<ImagePickerProvider>(context, listen: false)
                          .pickImageFromCamera();
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: () {
                      Provider.of<ImagePickerProvider>(context, listen: false)
                          .pickImageFromGallery();
                    },
                    icon: const Icon(
                      Icons.photo,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          title: TextFormField(
            controller: message,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Message...",
                hintStyle: TextStyle(color: Colors.black)),
            onEditingComplete: () {
              if (message.text.isNotEmpty) {
                DoubtsDB.sendMessage(
                    subject: subject,
                    message: message.text,
                    img: false,
                    username_phone: "username+phone");
              }
              message.clear();
            },
          ),
          trailing: IconButton(
            onPressed: () {
              if (image != null) {
                Provider.of<ImagePickerProvider>(context, listen: false)
                    .uploadImage(image, subject, "username+phone");
              }
              if (message.text.isNotEmpty) {
                DoubtsDB.sendMessage(
                    subject: subject,
                    message: message.text,
                    img: false,
                    username_phone: "username+phone");
              }
              message.clear();
            },
            icon: const Icon(
              Icons.send,
              color: Colors.blue,
            ),
          )),
    ),
  );
}

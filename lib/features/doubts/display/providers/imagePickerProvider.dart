// ignore_for_file: file_names, avoid_print, invalid_return_type_for_catch_error

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_portal/features/doubts/data/datasources/doubtsDB.dart';

class ImagePickerProvider extends ChangeNotifier {
  XFile? pickedImage;
  pickImageFromGallery() async {
    final XFile? img =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    pickedImage = img;
    notifyListeners();
  }

  pickImageFromCamera() async {
    final XFile? img =
        await ImagePicker().pickImage(source: ImageSource.camera);
    pickedImage = img;
    notifyListeners();
  }

  removePickedImage() async {
    pickedImage = null;
    notifyListeners();
  }

  uploadImage(XFile image, String subject, usernamePhone) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("images/image${DateTime.now().microsecondsSinceEpoch}");
    final metaData = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': image.path},
    );
    UploadTask uploadTask = ref.putFile(File(image.path), metaData);
    TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(
            () => print("Image uploaded successfully -----------------"))
        .catchError((e) => print("Something went wrong --------------"));
    String imgUrl = await taskSnapshot.ref.getDownloadURL();
    sendMessageProvider(subject, usernamePhone, imgUrl);
    pickedImage = null;
    notifyListeners();
  }

  sendMessageProvider(String subject, usernamePhone, url) async {
    DoubtsDB.sendMessage(
        subject: subject,
        message: url,
        img: true,
        username_phone: usernamePhone);
  }
}

// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/features/doubts/data/datasources/doubtsDB.dart';
import 'package:student_portal/features/doubts/display/providers/imagePickerProvider.dart';
import 'package:student_portal/features/doubts/display/widgets/messageBox.dart';
import 'package:student_portal/features/doubts/display/widgets/pickedImageWidget.dart';
import 'package:student_portal/features/doubts/display/widgets/studentTile.dart';
import 'package:student_portal/features/doubts/display/widgets/teacherTile.dart';

class Chating extends StatelessWidget {
  String subject;
  Chating({Key? key, required this.subject}) : super(key: key);

  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    XFile? pickedImage = Provider.of<ImagePickerProvider>(context).pickedImage;

    return Scaffold(
      appBar: AppBar(
        title: Text(subject.toUpperCase()),
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: DoubtsDB.chating("username+phone", subject),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("Start Chatting..."),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: ListView.builder(
                        // reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // ignore: prefer_interpolation_to_compose_strings
                          String admin = subject + '_admin';
                          if (snapshot.data!.docs[index]['senderID'] == admin) {
                            return teacherMessageTile(
                              context,
                              snapshot.data!.docs[index]['senderID'],
                              snapshot.data!.docs[index]['message'],
                              snapshot.data!.docs[index]['img'],
                            );
                          }
                          return studentMessageTile(
                              context,
                              snapshot.data!.docs[index]['senderID'],
                              snapshot.data!.docs[index]['message'],
                              snapshot.data!.docs[index]['img'],
                              snapshot.data!.docs[index].id,
                              subject,
                              "username+phone");
                        }),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
          pickedImageWidget(context, pickedImage),
          // attachmentContainer(context),
          messageBox(context, messageController, subject, pickedImage)
        ],
      ),
    );
  }
}

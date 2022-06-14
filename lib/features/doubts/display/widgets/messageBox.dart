// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:student_portal/features/doubts/data/datasources/doubtsDB.dart';

messageBox(TextEditingController message, String subject) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      color: Colors.grey[300],
      child: ListTile(
          leading: IconButton(
              onPressed: () {
                //
              },
              icon: const Icon(
                Icons.attach_file_outlined,
                color: Colors.black,
              )),
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

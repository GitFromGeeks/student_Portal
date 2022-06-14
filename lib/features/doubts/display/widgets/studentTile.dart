// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:student_portal/features/doubts/data/datasources/doubtsDB.dart';

studentMessageTile(context, String sender, message, bool img, String docId,
    subject, username) {
  return InkWell(
    onLongPress: () {
      unsentMessage(context, docId, subject, username);
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              child: Expanded(
                child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    color: const Color.fromARGB(255, 146, 134, 134),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (!img)
                          ? Text(
                              message,
                              style: const TextStyle(color: Colors.black),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Image.network(message)),
                    )),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

unsentMessage(context, String docId, subject, username) {
  return showDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.center,
          child: Wrap(
            spacing: 20,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber)),
                  onPressed: () {
                    DoubtsDB.deleteMessage(
                        docId: docId, subject: subject, username: username);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Unsent",
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
            ],
          ),
        );
      });
}



// ElevatedButton(
//           style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(Colors.amber)),
//           onPressed: () {
//             print("Unsent Button Clicked -------------");
//           },
//           child: const Text(
//             "Unsent",
//             style: TextStyle(color: Colors.black),
//           )),
//       ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text("Cancel")),
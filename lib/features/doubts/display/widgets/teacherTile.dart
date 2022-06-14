// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:student_portal/features/doubts/display/widgets/viewImage.dart';

teacherMessageTile(context, String sender, message, bool img) {
  return Hero(
    tag: "ImageView",
    child: InkWell(
      onTap: () {
        if (img) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImageView(image: message)));
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Expanded(
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: const Color.fromARGB(255, 229, 227, 227),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (!img)
                          ? Text(
                              message,
                              style: const TextStyle(color: Colors.black),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Image.network(message)),
                    )),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

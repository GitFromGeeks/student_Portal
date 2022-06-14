// ignore_for_file: file_names

import 'package:flutter/material.dart';

studentMessageTile(context, String sender, message, bool img) {
  return Column(
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
  );
}

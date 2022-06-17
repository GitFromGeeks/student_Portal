// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_portal/features/doubts/data/datasources/doubtsDB.dart';
import 'package:student_portal/features/doubts/display/pages/chating.dart';

class Doubts extends StatelessWidget {
  Doubts({Key? key}) : super(key: key);
  late Box box;

  callHive() async {
    box = await Hive.openBox("box");
  }

  @override
  Widget build(BuildContext context) {
    callHive();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Doubts"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: DoubtsDB.allSubjects(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return subjectCard(context, snapshot.data!.docs[index].id,
                        box.get(snapshot.data!.docs[index].id));
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

// Subject Card
Widget subjectCard(context, String subject, DateTime? lastCheckoutTime) {
  return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => Chating(
                  subject: subject,
                ))));
      },
      child: StreamBuilder<QuerySnapshot>(
        stream: DoubtsDB.messageCount("username+phone", subject),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Card(
                  color: Colors.amber[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            subject.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                        const Spacer(),
                        if (snapshot.data!.docs.isNotEmpty)
                          if (snapshot.data!.docs[0]['time'] != null)
                            if (lastCheckoutTime != null)
                              if (DateTime.fromMicrosecondsSinceEpoch(snapshot
                                      .data!
                                      .docs[0]['time']
                                      .microsecondsSinceEpoch)
                                  .isAfter(DateTime.fromMicrosecondsSinceEpoch(
                                      lastCheckoutTime.microsecondsSinceEpoch)))
                                const Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: CircleAvatar(
                                    maxRadius: 10,
                                    backgroundColor:
                                        Color.fromARGB(255, 0, 237, 12),
                                    child: Text(
                                      "+1",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ));
}

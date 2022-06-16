import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_portal/features/doubts/data/datasources/doubtsDB.dart';
import 'package:student_portal/features/doubts/display/pages/chating.dart';

class Doubts extends StatelessWidget {
  const Doubts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                    return subjectCard(context, snapshot.data!.docs[index].id);
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
Widget subjectCard(context, String subject) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => Chating(
                subject: subject,
              ))));
    },
    child: Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Card(
          color: Colors.amber[400],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Text(
              subject.toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    ),
  );
}

// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _doubtsCollection = _firestore.collection("doubts");

class DoubtsDB {
  // GET ALL SUBJECTS
  static Stream<QuerySnapshot> allSubjects() {
    return _doubtsCollection.snapshots();
  }

  // LIST OF ALL STUDENT_DOUBTS IN A SUBJECT COLLECTION
  static Stream<QuerySnapshot> doubtInASubject(String subject) {
    return _doubtsCollection
        .doc(subject)
        // ignore: prefer_interpolation_to_compose_strings
        .collection(subject + "_" + _doubtsCollection.id)
        .snapshots();
  }

  // Showing all messages
  // ignore: non_constant_identifier_names
  static Stream<QuerySnapshot> chating(String username_phone, subject) {
    return _doubtsCollection
        .doc(subject)
        .collection(subject + "_" + _doubtsCollection.id)
        .doc(username_phone)
        .collection(_doubtsCollection.id)
        .orderBy('time', descending: true)
        .snapshots();
  }

  //count unseen messages
  // static messageCount({context, required subject, required username}) async {
  //   _doubtsCollection
  //       .doc(subject)
  //       .collection(subject + "_" + _doubtsCollection.id)
  //       .doc(username)
  //       .collection(_doubtsCollection.id)
  //       .orderBy("time", descending: true)
  //       .limit(1)
  //       .get()
  //       .then((snap) {});
  // }
  static Stream<QuerySnapshot> messageCount(String username, subject) {
    return _doubtsCollection
        .doc(subject)
        .collection(subject + "_" + _doubtsCollection.id)
        .doc(username)
        .collection(_doubtsCollection.id)
        .orderBy('time', descending: true)
        .limit(1)
        .snapshots();
  }

  //delete message
  static Future<void> deleteMessage(
      {required String docId, required subject, required username}) async {
    _doubtsCollection
        .doc(subject)
        .collection(subject + "_" + _doubtsCollection.id)
        .doc(username)
        .collection(_doubtsCollection.id)
        .doc(docId)
        .delete();
  }

  //sending message
  static Future<void> sendMessage(
      {required String subject,
      required message,
      required bool img,
      // ignore: non_constant_identifier_names
      required username_phone}) async {
    DocumentReference documentReference = _doubtsCollection
        .doc(subject)
        // ignore: prefer_interpolation_to_compose_strings
        .collection(subject + "_" + _doubtsCollection.id)
        .doc(username_phone)
        .collection(_doubtsCollection.id)
        .doc();
    Map<String, dynamic> data = {
      'message': message,
      // ignore: prefer_interpolation_to_compose_strings
      'senderID': "username+phone",
      'time': DateTime.now(),
      'img': img
    };
    // ignore: avoid_print
    await documentReference.set(data).whenComplete(() => print("DONE"));
  }
}

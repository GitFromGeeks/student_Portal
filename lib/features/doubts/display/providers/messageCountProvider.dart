// ignore_for_file: file_names

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MessageCountProvider extends ChangeNotifier {
  late Box box;
  DateTime time = DateTime.now();

  // get last checkout
  void getLastCheckoutTime(String subject) async {
    box = await Hive.openBox("box");
    time = box.get(subject);
    notifyListeners();
  }

  // update last checkout
  void updateLastCheckoutTime(String subject) async {
    box = await Hive.openBox("box");
    box.put(subject, DateTime.now());
    time = DateTime.now();
    notifyListeners();
  }
}

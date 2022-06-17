// ignore_for_file: file_names

import 'package:hive/hive.dart';

part 'messageCountStorage.g.dart';

@HiveType(typeId: 1)
class MessageCountStorage {
  MessageCountStorage({required this.lastCheck});
  // Message Counters
  @HiveField(0)
  DateTime lastCheck;
}

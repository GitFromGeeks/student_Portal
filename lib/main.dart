import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/features/doubts/data/datasources/messageCountStorage.dart';
import 'package:student_portal/features/doubts/display/pages/doubts.dart';
import 'package:student_portal/features/doubts/display/providers/imagePickerProvider.dart';
import 'package:student_portal/features/doubts/display/providers/messageCountProvider.dart';

late Box box;

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter<MessageCountStorage>(MessageCountStorageAdapter());
  }
  box = await Hive.openBox("box");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "Student Portal",
      options: const FirebaseOptions(
          apiKey: "AIzaSyA1tgBPVHFACPN2kiQNNIfIT_EVnGy80L0",
          authDomain: "doubt-5dab8.firebaseapp.com",
          projectId: "doubt-5dab8",
          storageBucket: "doubt-5dab8.appspot.com",
          messagingSenderId: "509629511789",
          appId: "1:509629511789:web:7fdc4e2d74b898c3576764",
          measurementId: "G-ZN8G439BLT"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImagePickerProvider()),
        ChangeNotifierProvider(create: (context) => MessageCountProvider()),
      ],
      child: MaterialApp(
        title: "Student Portal",
        theme: ThemeData.dark(),
        home: Doubts(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

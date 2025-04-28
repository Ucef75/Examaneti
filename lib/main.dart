import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/add_exam_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyByQ3c2lU6hN0WyJufFOz9M5BEa-wC9VTM",
        authDomain: "appflutter-2a1e7.firebaseapp.com",
        projectId: "appflutter-2a1e7",
        storageBucket: "appflutter-2a1e7.appspot.com", // I also fixed a typo here (was wrong in your storageBucket)
        messagingSenderId: "514872078538",
        appId: "1:514872078538:web:ac0dd6bd44a31f75070433",
        databaseURL: 'https://myapp-1234.firebaseio.com',
      ),
    );
  } else {
    await Firebase.initializeApp(); // <-- Add await here!
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exam Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AddExamScreen(), // Small fix: make it const
    );
  }
}

import 'Pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/add_exam_screen.dart';
import 'package:flutter/foundation.dart' as Foundation; // For checking web platform

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase initialization for Web
  if (Foundation.kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyByQ3c2lU6hN0WyJufFOz9M5BEa-wC9VTM",
        authDomain: "appflutter-2a1e7.firebaseapp.com",
        projectId: "appflutter-2a1e7",
        storageBucket: "appflutter-2a1e7.appspot.com", 
        messagingSenderId: "514872078538",
        appId: "1:514872078538:web:ac0dd6bd44a31f75070433",
        databaseURL: 'https://myapp-1234.firebaseio.com',
      ),
    );
  } else {
    // Firebase initialization for Android/iOS
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AddExamScreen(), // Start with the Add Exam screen
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/screens/auth_screens/login.dart';
import 'package:myapp/screens/dashboard/Home.dart';
import 'package:myapp/screens/dashboard/Settings.dart';
import 'package:myapp/screens/Calender_screens/calender.dart';
import 'package:myapp/l10n/l10n.dart';
import 'package:myapp/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:myapp/screens/exam_screens/examDashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "your-api-key",
          appId: "your-app-id",
          messagingSenderId: "your-messaging-sender-id",
          projectId: "your-project-id",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  runApp(const ExamManagementApp());
}

class ExamManagementApp extends StatelessWidget {
  const ExamManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exam Management',
      theme: lightTheme,
      darkTheme: darkTheme,
      locale: _locale, // 🔥 ici on injecte la locale dynamique
      supportedLocales: L10n.all,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/exams': (context) => const CalendarPage(userRole: 'student', userId: 'userId'),
        '/results': (context) => const Scaffold(body: Center(child: Text('Results Page'))),
        '/settings': (context) => const SettingsScreen(),
        '/Logout': (context) => const LoginPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ExamDashboard(), // Set ExamDashboard as the home screen
    );
  }
}

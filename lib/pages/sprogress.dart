import 'package:flutter/material.dart';
class StudentProgressPage extends StatelessWidget {
  const StudentProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Progress')),
      body: const Center(child: Text('Student Progress Page')),
    );
  }
}
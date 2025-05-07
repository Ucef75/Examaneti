import 'package:flutter/material.dart';

class ManageExamsPage extends StatelessWidget {
  const ManageExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Exams')),
      body: const Center(child: Text('Manage Exams Page')),
    );
  }
}
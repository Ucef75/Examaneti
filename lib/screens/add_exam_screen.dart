import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/exam.dart';
import '../services/exam_service.dart';

class AddExamScreen extends StatefulWidget {
  @override
  _AddExamScreenState createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  final TextEditingController _classRefController = TextEditingController();
  final TextEditingController _examNameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _fileUrlController = TextEditingController();
  final TextEditingController _timeLimitController = TextEditingController();
  final ExamService _examService = ExamService();

  void _submitExam() async {
    if (_examNameController.text.isEmpty ||
        _classRefController.text.isEmpty ||
        _typeController.text.isEmpty ||
        _fileUrlController.text.isEmpty ||
        _timeLimitController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    String examId = Uuid().v4();

    Exam newExam = Exam(
      examId: examId,
      classRef: _classRefController.text,
      examName: _examNameController.text,
      type: _typeController.text,
      fileUrl: _fileUrlController.text,
      timeLimit: int.parse(_timeLimitController.text),
    );

    try {
      await _examService.addExam(newExam);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exam added successfully")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add exam")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Exam")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _classRefController,
              decoration: InputDecoration(labelText: "Class Reference"),
            ),
            TextField(
              controller: _examNameController,
              decoration: InputDecoration(labelText: "Exam Name"),
            ),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: "Type"),
            ),
            TextField(
              controller: _fileUrlController,
              decoration: InputDecoration(labelText: "File URL"),
            ),
            TextField(
              controller: _timeLimitController,
              decoration: InputDecoration(labelText: "Time Limit (minutes)"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitExam,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

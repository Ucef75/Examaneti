import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/exam.dart';
import '../../services/exam_service.dart';

class AddExamScreen extends StatefulWidget {
  const AddExamScreen({super.key, required DateTime presetDate, required String professorId, required Null Function() onExamAdded});

  @override
  _AddExamScreenState createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  final TextEditingController _classIdController = TextEditingController();
  final TextEditingController _correctionDeadlineController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _examTypeController = TextEditingController();
  final TextEditingController _fileUrlController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _professorIdController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _timeLimitController = TextEditingController();

  final ExamService _examService = ExamService();

  void _submitExam() async {
    if (_classIdController.text.isEmpty ||
        _correctionDeadlineController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _titleController.text.isEmpty ||
        _examTypeController.text.isEmpty ||
        _fileUrlController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _professorIdController.text.isEmpty ||
        _statusController.text.isEmpty ||
        _timeLimitController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    String examId = Uuid().v4();

    Exam newExam = Exam(
      examId: examId,
      classId: _classIdController.text,
      correctionDeadline: _correctionDeadlineController.text,
      description: _descriptionController.text,
      title: _titleController.text,
      examType: _examTypeController.text,
      fileUrl: _fileUrlController.text,
      date: _dateController.text,
      professorId: _professorIdController.text,
      status: _statusController.text,
      timeLimit: int.parse(_timeLimitController.text),
    );

    try {
      await _examService.addExam(newExam);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Exam added successfully")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add exam")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Exam")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // In case the form is long
          child: Column(
            children: [
              TextField(
                controller: _classIdController,
                decoration: const InputDecoration(labelText: "Class ID"),
              ),
              TextField(
                controller: _correctionDeadlineController,
                decoration: const InputDecoration(labelText: "Correction Deadline"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: _examTypeController,
                decoration: const InputDecoration(labelText: "Exam Type"),
              ),
              TextField(
                controller: _fileUrlController,
                decoration: const InputDecoration(labelText: "File URL"),
              ),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: "Exam Date"),
              ),
              TextField(
                controller: _professorIdController,
                decoration: const InputDecoration(labelText: "Professor ID"),
              ),
              TextField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: "Status"),
              ),
              TextField(
                controller: _timeLimitController,
                decoration: const InputDecoration(labelText: "Time Limit (minutes)"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitExam,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

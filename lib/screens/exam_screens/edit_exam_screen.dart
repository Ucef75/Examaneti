import 'package:flutter/material.dart';
import '../../models/exam.dart';
import '../../services/exam_service.dart';

class EditExamScreen extends StatefulWidget {
  final Exam exam; // Pass the existing Exam object to edit

  const EditExamScreen({super.key, required this.exam});

  @override
  _EditExamScreenState createState() => _EditExamScreenState();
}

class _EditExamScreenState extends State<EditExamScreen> {
  late TextEditingController _classIdController;
  late TextEditingController _correctionDeadlineController;
  late TextEditingController _descriptionController;
  late TextEditingController _titleController;
  late TextEditingController _examTypeController;
  late TextEditingController _fileUrlController;
  late TextEditingController _dateController;
  late TextEditingController _professorIdController;
  late TextEditingController _statusController;
  late TextEditingController _timeLimitController;

  final ExamService _examService = ExamService();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the existing exam values
    _classIdController = TextEditingController(text: widget.exam.classId);
    _correctionDeadlineController = TextEditingController(text: widget.exam.correctionDeadline);
    _descriptionController = TextEditingController(text: widget.exam.description);
    _titleController = TextEditingController(text: widget.exam.title);
    _examTypeController = TextEditingController(text: widget.exam.examType);
    _fileUrlController = TextEditingController(text: widget.exam.fileUrl);
    _dateController = TextEditingController(text: widget.exam.date);
    _professorIdController = TextEditingController(text: widget.exam.professorId);
    _statusController = TextEditingController(text: widget.exam.status);
    _timeLimitController = TextEditingController(text: widget.exam.timeLimit.toString());
  }

  @override
  void dispose() {
    _classIdController.dispose();
    _correctionDeadlineController.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
    _examTypeController.dispose();
    _fileUrlController.dispose();
    _dateController.dispose();
    _professorIdController.dispose();
    _statusController.dispose();
    _timeLimitController.dispose();
    super.dispose();
  }

  void _updateExam() async {
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

    Exam updatedExam = Exam(
      examId: widget.exam.examId, // Keep the same exam ID
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
      await _examService.addExam(updatedExam); // Just overwrite the document with same ID
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Exam updated successfully")),
      );
      Navigator.pop(context); // Go back after editing
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update exam")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Exam")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                onPressed: _updateExam,
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

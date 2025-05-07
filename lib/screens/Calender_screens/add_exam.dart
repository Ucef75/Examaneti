import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/exam.dart';
import '../../services/exam_service.dart';

class AddExamForm extends StatefulWidget {
  final DateTime presetDate;
  final String professorId;
  final VoidCallback? onExamAdded;

  const AddExamForm({
    super.key,
    required this.presetDate,
    required this.professorId,
    this.onExamAdded,
  });

  @override
  State<AddExamForm> createState() => _AddExamFormState();
}

class _AddExamFormState extends State<AddExamForm> {
  final TextEditingController _classIdController = TextEditingController();
  final TextEditingController _correctionDeadlineController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _examTypeController = TextEditingController();
  final TextEditingController _fileUrlController = TextEditingController();
  final TextEditingController _timeLimitController = TextEditingController();

  final ExamService _examService = ExamService();
  late final String _dateStr;

  @override
  void initState() {
    super.initState();
    _dateStr =
        "${widget.presetDate.year}-${widget.presetDate.month.toString().padLeft(2, '0')}-${widget.presetDate.day.toString().padLeft(2, '0')}";
  }

  void _submitExam() async {
    if (_classIdController.text.isEmpty ||
        _correctionDeadlineController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _titleController.text.isEmpty ||
        _examTypeController.text.isEmpty ||
        _fileUrlController.text.isEmpty ||
        _timeLimitController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final examId = const Uuid().v4();

    final newExam = Exam(
      examId: examId,
      classId: _classIdController.text,
      correctionDeadline: _correctionDeadlineController.text,
      description: _descriptionController.text,
      title: _titleController.text,
      examType: _examTypeController.text,
      fileUrl: _fileUrlController.text,
      date: _dateStr,
      professorId: widget.professorId,
      status: 'scheduled',
      timeLimit: int.parse(_timeLimitController.text),
    );

    try {
      await _examService.addExam(newExam);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Exam added successfully")),
      );
      widget.onExamAdded?.call();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add exam")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add Exam for: $_dateStr", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
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
              controller: _timeLimitController,
              decoration: const InputDecoration(labelText: "Time Limit (minutes)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _submitExam,
                child: const Text("Submit Exam"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

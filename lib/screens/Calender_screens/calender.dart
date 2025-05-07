import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/exam.dart';
import 'package:myapp/screens/exam_screens/add_exam_screen.dart';
import 'package:myapp/services/exam_service.dart';

class CalendarPage extends StatefulWidget {
  final String userRole; // 'student' or 'professor'
  final String userId;

  const CalendarPage({
    super.key,
    required this.userRole,
    required this.userId,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Exam> _allExams = [];

  final ExamService _examService = ExamService();

  @override
  void initState() {
    super.initState();
    _fetchExams();
  }

  Future<void> _fetchExams() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('exams').get();
      final exams = snapshot.docs.map((doc) => Exam.fromFirestore(doc)).toList();

      setState(() {
        _allExams = exams.cast<Exam>();
      });
    } catch (e) {
      print("Error fetching exams: $e");
    }
  }

  List<Exam> _getExamsForDay(DateTime day) {
    final dateStr = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
    return _allExams.where((exam) => exam.date == dateStr).toList();
  }

  void _showExamDialog(DateTime day) {
    final exams = _getExamsForDay(day);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Exams on ${day.toLocal().toString().split(' ')[0]}"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (exams.isEmpty)
                const Text("No exams.")
              else
                ...exams.map((exam) => ListTile(
                      title: Text(exam.title),
                      subtitle: Text(exam.description),
                      trailing: widget.userRole == 'professor'
                          ? IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await _examService.deleteExam(exam.examId);
                                Navigator.pop(context);
                                _fetchExams();
                              },
                            )
                          : null,
                    )),
              const SizedBox(height: 10),
              if (widget.userRole == 'professor')
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Add Exam"),
                  onPressed: () {
                    Navigator.pop(context);
                    _showAddExamPopup(day);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddExamPopup(DateTime day) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: SizedBox(
          width: 400,
          height: 600,
          child: AddExamScreen(
            presetDate: day,
            professorId: widget.userId,
            onExamAdded: () {
              Navigator.pop(context);
              _fetchExams();
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.userRole.toUpperCase()} Calendar')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _showExamDialog(selectedDay);
            },
            eventLoader: _getExamsForDay,
            calendarStyle: const CalendarStyle(
              markerDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}

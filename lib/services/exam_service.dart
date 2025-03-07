import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/exam.dart';

class ExamService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addExam(Exam exam) async {
    try {
      await _firestore.collection('exams').doc(exam.examId).set(exam.toJson());
    } catch (e) {
      print("Error adding exam: $e");
      throw e;
    }
  }
}

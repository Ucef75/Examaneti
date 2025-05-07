import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/exam.dart';

class ExamService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Add a new exam to Firestore
  Future<void> addExam(Exam exam) async {
    try {
      await _firestore
          .collection('exams')
          .doc(exam.examId)
          .set(exam.toJson());
    } on FirebaseException catch (e) {
      print("Firebase error adding exam: ${e.message}");
      rethrow;
    } catch (e) {
      print("Unknown error adding exam: $e");
      rethrow;
    }
  }

  /// Fetch all exams
  Future<List<Exam>> getExams() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('exams').get();
      return snapshot.docs
          .map((doc) => Exam.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching exams: $e");
      rethrow;
    }
  }

  /// Delete an exam
  Future<void> deleteExam(String examId) async {
    try {
      await _firestore.collection('exams').doc(examId).delete();
    } catch (e) {
      print("Error deleting exam: $e");
      rethrow;
    }
  }

  /// ✅ Fetch exams for a specific date (yyyy-MM-dd)
  Future<List<Exam>> getExamsForDate(String dateStr) async {
    try {
      final snapshot = await _firestore
          .collection('exams')
          .where('date', isGreaterThanOrEqualTo: dateStr)
          .where('date', isLessThan: '${dateStr}z')
          .get();

      return snapshot.docs
          .map((doc) => Exam.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching exams for date: $e");
      rethrow;
    }
  }
}

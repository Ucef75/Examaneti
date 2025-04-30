class Exam {
  String examId;
  String classId;
  String correctionDeadline;
  String description;
  String title;
  String examType;
  String fileUrl;
  String date;
  String professorId;
  String status;
  int timeLimit;

  Exam({
    required this.examId,
    required this.description,
    required this.classId,
    required this.correctionDeadline,
    required this.title,
    required this.examType,
    required this.fileUrl,
    required this.professorId,
    required this.status,
    required this.date,
    required this.timeLimit,
  });

  // Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'examId': examId,
      'classId': classId,
      'correctionDeadline': correctionDeadline,
      'description': description,
      'title': title,
      'examType': examType,
      'fileUrl': fileUrl,
      'professorId': professorId,
      'status': status,
      'date': date,
      'timeLimit': timeLimit,
    };
  }
  

  // Factory constructor to create an Exam from Firestore data
  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      examId: json['examId'],
      classId: json['classId'],
      title: json['title'],
      fileUrl: json['fileUrl'],
      timeLimit: json['timeLimit'],
      description: json['description'],
      correctionDeadline: json['correctionDeadline'],
      date: json['date'],
      professorId: json['professorId'],
      status: json['status'],
      examType: json['examType']
    );
  }
}

class Exam {
  String examId;
  String classRef;
  String examName;
  String type;
  String fileUrl;
  int timeLimit;

  Exam({
    required this.examId,
    required this.classRef,
    required this.examName,
    required this.type,
    required this.fileUrl,
    required this.timeLimit,
  });

  // Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'examId': examId,
      'classRef': classRef,
      'examName': examName,
      'type': type,
      'fileUrl': fileUrl,
      'timeLimit': timeLimit,
    };
  }

  // Factory constructor to create an Exam from Firestore data
  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      examId: json['examId'],
      classRef: json['classRef'],
      examName: json['examName'],
      type: json['type'],
      fileUrl: json['fileUrl'],
      timeLimit: json['timeLimit'],
    );
  }
}

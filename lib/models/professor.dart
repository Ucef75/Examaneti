import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/user.dart';

class Professor extends User {
  String department;

  Professor({
    required super.userId,
    required super.userFullName,
    required super.userEmail,
    required super.userRole,
    required super.userDateOfBirth,
    required super.userPhoneNumber,
    required super.userGender,
    required super.userAddress,
    required super.userProfileImageUrl,
    required super.userCreatedAt,
    // required super.userPassword,
    required this.department,
  });

  /// Convert Professor to JSON, reusing User's toJson
  @override
  Map<String, dynamic> toJson() {
    final userJson = super.toJson(); // Reuse User's toJson
    userJson['userDepartment'] = department; // Add department field
    return userJson;
  }

  /// Factory constructor to create a Professor from JSON
  factory Professor.fromJson(Map<String, dynamic> json) {
    return Professor(
      userId: json['userId'] ?? '',
      userFullName: json['userFullName'] ?? '',
      userEmail: json['userEmail'] ?? '',
      userRole: json['userRole'] ?? '',
      userDateOfBirth: DateTime.parse(
          json['userDateOfBirth'] ?? DateTime.now().toIso8601String()),
      userPhoneNumber: json['userPhoneNumber'] ?? '',
      userGender: json['userGender'] ?? '',
      userAddress: json['userAddress'] ?? '',
      userProfileImageUrl: json['userProfileImageUrl'] ?? '',
      userCreatedAt: DateTime.parse(
          json['userCreatedAt'] ?? DateTime.now().toIso8601String()),
      department: json['userDepartment'] ?? '', // Handle null safely
    );
  }

  /// Static method to create a Professor from Firestore
  static Professor fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Professor.fromJson(data); // Reuse fromJson for consistency
  }
}

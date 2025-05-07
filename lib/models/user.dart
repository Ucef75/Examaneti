import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userId;
  String userFullName;
  String userEmail;
  String userRole;
  DateTime userDateOfBirth; // Changed to DateTime
  String userPhoneNumber;
  String userGender;
  String userAddress;
  String userProfileImageUrl;
  DateTime userCreatedAt; // Changed to DateTime
  // String? userPassword; // Uncomment if needed and handle securely

  User({
    required this.userId,
    required this.userFullName,
    required this.userEmail,
    required this.userRole,
    required this.userDateOfBirth,
    required this.userPhoneNumber,
    required this.userGender,
    required this.userAddress,
    required this.userProfileImageUrl,
    required this.userCreatedAt,
    // this.userPassword,
  });

  /// Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userFullName': userFullName,
      'userEmail': userEmail,
      'userRole': userRole,
      'userDateOfBirth':
          userDateOfBirth.toIso8601String(), // Convert DateTime to String
      'userPhoneNumber': userPhoneNumber,
      'userGender': userGender,
      'userAddress': userAddress,
      'userProfileImageUrl': userProfileImageUrl,
      'userCreatedAt':
          userCreatedAt.toIso8601String(), // Convert DateTime to String
      // 'userPassword': userPassword,
    };
  }

  /// Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      // userPassword: json['userPassword'], // Uncomment if needed
    );
  }

  /// Static method to create a User from Firestore
  static User fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User.fromJson(data); // Reuse fromJson for consistency
  }
}

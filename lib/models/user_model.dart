// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  // final String id;
  String? fullName;
  String phoneNo;
  String? email;
  String? profilePic;
  // String? authType;
  UserModel({
    this.fullName,
    required this.phoneNo,
    this.email,
    this.profilePic,
  });

  UserModel copyWith({
    String? fullName,
    String? phoneNo,
    String? email,
    String? profilePic,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      phoneNo: phoneNo ?? this.phoneNo,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'phone': phoneNo,
      'email': email,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'],
      phoneNo: map['phone'],
      email: map['email'],
      profilePic: map['profilePic'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel( fullName: $fullName, phoneNo: $phoneNo, email: $email, profilePic: $profilePic)';
  }
}

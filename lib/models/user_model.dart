// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  String? fullName;
  String? phoneNo;
  String? email;
  String? profilePic;
  String? authType;
  UserModel({
    required this.id,
    this.authType,
    this.fullName,
    this.phoneNo,
    this.email,
    this.profilePic,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? phoneNo,
    String? email,
    String? profilePic,
    String? authType,
  }) {
    return UserModel(
      id: id ?? this.id,
      authType: authType ?? this.authType,
      fullName: fullName ?? this.fullName,
      phoneNo: phoneNo ?? this.phoneNo,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'phoneNo': phoneNo,
      'email': email,
      'auth_type': authType,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      phoneNo: map['phoneNo'],
      email: map['email'],
      authType: map['auth_type'],
      profilePic: map['profilePic'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, phoneNo: $phoneNo, email: $email, profilePic: $profilePic)';
  }
}

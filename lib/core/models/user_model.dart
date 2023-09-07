// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final Timestamp createdAt;
  final String email;
  final String imageUrl;
  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.email, 
    required this.imageUrl
  });

  UserModel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    Timestamp? createdAt,
    String? email,
    String? imageUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
    imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'createdAt': createdAt});
    result.addAll({'email': email});
    result.addAll({'imageUrl': imageUrl});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, firstName: $firstName, lastName: $lastName, createdAt: $createdAt, email: $email, imageUrl: $imageUrl)';
  }
}

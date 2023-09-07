// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TextModel {
  final String id;
  final String createdBy;
  final Timestamp createdAt;
  final String message;
  TextModel({
    required this.id,
    required this.createdBy,
    required this.createdAt,
    required this.message,
  });

  TextModel copyWith({
    String? id,
    String? createdBy,
    Timestamp? createdAt,
    String? message,
  }) {
    return TextModel(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'message': message,
    };
  }

  factory TextModel.fromMap(Map<String, dynamic> map) {
    return TextModel(
      id: map['id'] as String,
      createdBy: map['createdBy'] as String,
      createdAt: map['createdAt'] as Timestamp,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TextModel.fromJson(String source) =>
      TextModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TextModel(id: $id, createdBy: $createdBy, createdAt: $createdAt, message: $message)';
  }
}

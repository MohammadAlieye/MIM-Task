// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoModel {
  final String id;
  final String createdBy;
  final Timestamp createdAt;
  final String url;
  final String name;
  PhotoModel({
    required this.id,
    required this.createdBy,
    required this.createdAt,
    required this.url,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'url': url,
      'name': name,
    };
  }

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      id: map['id'] as String,
      createdBy: map['createdBy'] as String,
      createdAt: map['createdAt'] as Timestamp,
      url: map['url'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotoModel.fromJson(String source) =>
      PhotoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PhotoModel(id: $id, createdBy: $createdBy, createdAt: $createdAt, url: $url, name: $name)';
  }
}

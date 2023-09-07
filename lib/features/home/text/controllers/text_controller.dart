import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/services/firebase/database/firestore_service.dart';
import 'package:task/core/utils/functions/functions.dart';
import 'package:task/features/home/text/models/text_model.dart';

class TextController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final text = TextEditingController();

  sendMessage() {
    if (text.text.trim().isEmpty) return;
    final message = TextModel(
      id: getRandomString(25),
      createdBy: _auth.currentUser!.uid,
      createdAt: Timestamp.now(),
      message: text.text.trim(),
    );
    text.clear();
    FirestoreService.sendMessage(message);
  }
}

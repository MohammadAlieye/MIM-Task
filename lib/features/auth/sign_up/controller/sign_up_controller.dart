import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/controllers/user_controller.dart';
import 'package:task/core/models/user_model.dart';
import 'package:task/core/services/firebase/auth/firebase_auth_service.dart';
import 'package:task/core/utils/widgets/dialog.dart';

class SignUpController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void signUp() async {
    try {
    if (!formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final userCredential = await SignUpService()
        .signUpWithEmailAndPassword(email.text.trim(), password.text);
    if (userCredential == null) return;

      final user = userCredential.user;
    if (user != null) {
     AuthController.currentUser = UserModel(
        uid: user.uid,
        email: user.email ?? '', firstName: '', lastName: '', createdAt: Timestamp.now(), imageUrl: '',
      );
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(AuthController.currentUser!.toMap());

    } 
    AppDialog().showOSDialog(
      context: Get.context!,
      title: "Congratulations",
      message:
          "Your account has been successfully created. Please Sign in again",
      secondButtonText: "Close",
      secondCallBack: () {
        Get.back();
        Get.back();
      },
    );
    
    } catch (e) {
    print('Error signing in: $e');
  }
  }
}

    
   
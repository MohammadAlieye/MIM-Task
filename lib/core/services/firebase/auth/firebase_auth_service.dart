import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task/core/utils/widgets/dialog.dart';

import '../../../utils/helper/loading_helper.dart';

abstract class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _okay = "Okay";
  final String _someThingWentWrong = "Something went wrong. Try Again.";
}

class SignInService extends FirebaseAuthService {
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      LoadingHelper.showLoading();
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      LoadingHelper.hideLoading();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      LoadingHelper.hideLoading();
      AppDialog().showOSDialog(
        context: Get.context!,
        title: e.code.capitalizeFirst ?? '',
        message: e.message ?? _someThingWentWrong,
        secondButtonText: _okay,
        secondCallBack: Get.back,
      );
    }
    return null;
  }
}

class SignUpService extends FirebaseAuthService {
  Future<UserCredential?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      LoadingHelper.showLoading();
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      LoadingHelper.hideLoading();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
      AppDialog().showOSDialog(
        context: Get.context!,
        title: e.code.capitalizeFirst ?? '',
        message: e.message ?? _someThingWentWrong,
        secondButtonText: _okay,
        secondCallBack: Get.back,
      );
    }
    return null;
  }
}

class SignOutService extends FirebaseAuthService {
  Future<bool> signOut() async {
    bool isSuccess = false;
    try {
      LoadingHelper.showLoading();
      await _auth.signOut();
      LoadingHelper.hideLoading();
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
      AppDialog().showOSDialog(
        context: Get.context!,
        title: e.code.capitalizeFirst ?? '',
        message: e.message ?? _someThingWentWrong,
        secondButtonText: _okay,
        secondCallBack: Get.back,
      );
    }
    return isSuccess;
  }
}

class ForgetPasswordService extends FirebaseAuthService {
  Future<bool> forgetPassword(String email) async {
    try {
      LoadingHelper.showLoading();
      await _auth.sendPasswordResetEmail(
        email: email,
      );
      LoadingHelper.hideLoading();
      return true;
    } on FirebaseAuthException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
      AppDialog().showOSDialog(
        context: Get.context!,
        title: e.code.capitalizeFirst ?? '',
        message: e.message ?? _someThingWentWrong,
        secondButtonText: _okay,
        secondCallBack: Get.back,
      );
      return false;
    }
  }
}

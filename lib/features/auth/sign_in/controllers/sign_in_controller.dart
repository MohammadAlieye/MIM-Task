import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:task/core/services/firebase/auth/firebase_auth_service.dart';
import 'package:task/core/utils/helper/loading_helper.dart';
import '../../../home/home_view.dart';

class SignInController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
   final FirebaseAuth _auth = FirebaseAuth.instance;

  void showPassword() {
    obscureText = !obscureText;
    update();
  }

  void sigIn() async {
      try {
    if (!formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final userCredential = await SignInService()
        .signInWithEmailAndPassword(email.text.trim(), password.text);
    if (userCredential == null) return;
    Get.offAll(() => const HomeView());
    
     } catch (e) {
    debugPrint('Error signing in: $e');
  }
   
  }

  

  Future<void> loginWithGoogle() async {
    try { LoadingHelper.showLoading();
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
      if (googleSignInAuthentication == null) return;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
     await _auth.signInWithCredential(credential);
  LoadingHelper.hideLoading();
    Get.offAll(() => const HomeView());
    
    } on FirebaseAuthException catch (e) {
      debugPrint("e: $e");  
      LoadingHelper.hideLoading();
    } on Exception catch (e) {
      debugPrint("e: $e");  
      LoadingHelper.hideLoading();
    }
  }



Future<void> signInWithApple() async {
    try {LoadingHelper.showLoading();
      final AppleSignInAvailable appleSignInAvailable = await AppleSignInAvailable.check();
      if (!appleSignInAvailable.isAvailable) {
        // AppDialog().showOSDialog(context, "Error", "Apple Sign in not available", "Ok", () {});
        return;
      }
      const String appleProvider = "apple.com";
  

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider(appleProvider).credential(
        idToken: appleCredential.identityToken,
      );

       await _auth.signInWithCredential(oauthCredential);
     LoadingHelper.hideLoading();
      Get.offAll(() => const HomeView());
    } on SignInWithAppleException catch (e) {
      debugPrint("Apple Login Error: $e");LoadingHelper.hideLoading();
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase Auth Error: $e");LoadingHelper.hideLoading();
    }
  }



  // Future<User?> signInWithApple() async {
  //   try {
  //     final result = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );

  //     final AuthCredential credential = OAuthProvider('apple.com').credential(
  //       idToken: result.identityToken,
  //       accessToken: result.authorizationCode,
  //     );

  //     final UserCredential authResult =
  //         await _auth.signInWithCredential(credential);
  //     final User? user = authResult.user;
  //     return user;
  //   } catch (error) {
  //     print(error);
  //     return null;
  //   }
  // }
}
class AppleSignInAvailable {
  AppleSignInAvailable(this.isAvailable);
  final bool isAvailable;

  static Future<AppleSignInAvailable> check() async {
    return AppleSignInAvailable(await SignInWithApple.isAvailable());
  }
}
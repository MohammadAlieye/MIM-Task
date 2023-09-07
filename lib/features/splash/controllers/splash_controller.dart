import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task/features/auth/sign_in/views/signin_view.dart';
import 'package:task/features/home/home_view.dart';

class SplashController extends GetxController {
  SplashController();

  @override
  void onInit() {
    navigateUser();
    super.onInit();
  }

  void navigateUser() async {
    await Future.delayed(const Duration(seconds: 3));
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.offAll(() => const SignInView());
      return;
    }
    Get.offAll(() => const HomeView());
  }
}

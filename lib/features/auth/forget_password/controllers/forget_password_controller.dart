import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/services/firebase/auth/firebase_auth_service.dart';
import 'package:task/core/utils/widgets/dialog.dart';

class ForgetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  submit() async {
    if (!formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final isSucess =
        await ForgetPasswordService().forgetPassword(email.text.trim());
    if (!isSucess) return;
    email.clear();
    AppDialog().showOSDialog(
        context: Get.context!,
        title: "Success",
        message:
            "Password reset request was sent successfully. Please check your email to reset your password",
        secondButtonText: "Done",
        secondCallBack: () {
          Get.back();
          Get.back();
        });
  }
}

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/constants/app_assets.dart';
import 'package:task/core/constants/app_size.dart';
import 'package:task/core/utils/extensions/extensions.dart';
import 'package:task/features/auth/forget_password/view/forget_password_view.dart';
import 'package:task/features/auth/sign_in/controllers/sign_in_controller.dart';
import 'package:task/features/auth/sign_up/view/sign_up_view.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/utils/widgets/buttons.dart';
import '../../../../core/utils/widgets/textfields.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final signInController = Get.put(SignInController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSize.sidePadding),
              child: Form(
                key: signInController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 35),
                    Image.asset(
                      AppAssets.logoJPG,
                      width: 100,
                    ),
                    const SizedBox(height: 30),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Welcome,\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "Glad to see you!",
                          ),
                        ],
                      ),
                      style: TextStyle(fontSize: 32),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      labelText: 'Email',
                      controller: signInController.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter enter your email address';
                        }
                        if (!value.isEmail) {
                          return 'Please enter valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    GetBuilder<SignInController>(
                      builder: (controller) => CustomTextField(
                          labelText: 'Password',
                          controller: signInController.password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 8) {
                              return 'Please enter minimum 8 characters';
                            }
                            if (!value.isCotainUpperCase) {
                              return 'Must contain at least 1 uppercase';
                            }
                            if (!value.isContainLowerCase) {
                              return 'Must contain at least 1 lowercase';
                            }
                            if (!value.isContainSymbol) {
                              return 'Must contain at least 1 special symbol';
                            }
                            return null;
                          },
                          obscureText: controller.obscureText,
                          suffixIcon: IconButton(
                            icon: controller.obscureText
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: controller.showPassword,
                          )),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Forget password?",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => _forgetPassword(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    AppButton(
                      minWidth: double.infinity,
                      onTap: signInController.sigIn,
                      title: "Sign In",
                      color: AppColor.kBlue,
                      titleColor: AppColor.white,
                    ),
                    const SizedBox(height: 20),
                     AppButton(
                      icon: AppAssets.google,
                      minWidth: double.infinity,
                      onTap: signInController.loginWithGoogle,
                      title: "Continue with Google",
                      color: AppColor.kBlue,
                      titleColor: AppColor.white,
                    ),
                    
                    const SizedBox(height: 20),
                    if(Platform.isIOS)
                     AppButton(
                      icon: AppAssets.apple,
                      minWidth: double.infinity,
                      onTap: signInController.signInWithApple,
                      title: "Continue with Apple",
                      color: AppColor.kBlue,
                      titleColor: AppColor.white,
                    ),
                    
                    const SizedBox(height: 100),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: "Sign Up",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _signUp(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _forgetPassword() {
    Get.to(() => const ForgetPasswordView());
  }

  void _signUp() {
    Get.to(() => const SignUpView());
  }
}

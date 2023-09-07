import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/constants/app_assets.dart';
import 'package:task/core/constants/app_size.dart';
import 'package:task/core/utils/extensions/extensions.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/utils/widgets/buttons.dart';
import '../../../../core/utils/widgets/textfields.dart';
import '../controller/sign_up_controller.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSize.sidePadding),
              child: Form(
                key: signUpController.formKey,
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
                            text: "Create Account,\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "to get started now!",
                          ),
                        ],
                      ),
                      style: TextStyle(fontSize: 32),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      labelText: 'Email',
                      controller: signUpController.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (!value.isEmail) {
                          return 'Please enter correct email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      labelText: 'Password',
                      controller: signUpController.password,
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
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      labelText: 'Confirm Password',
                      controller: signUpController.confirmPassword,
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
                        if (signUpController.password.text !=
                            signUpController.confirmPassword.text) {
                          return 'Password and confirm password does not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    AppButton(
                      minWidth: double.infinity,
                      onTap: signUpController.signUp,
                      title: "Sign Up",
                      color: AppColor.kBlue,
                      titleColor: AppColor.white,
                    ),
                    const SizedBox(height: 100),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "Already have an account? "),
                          TextSpan(
                            text: "Sign In",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _signIn(),
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

  void _signIn() {
    Get.back();
  }
}

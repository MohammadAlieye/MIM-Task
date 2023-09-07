import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_size.dart';
import 'package:task/core/utils/widgets/buttons.dart';
import 'package:task/core/utils/widgets/textfields.dart';
import 'package:task/features/auth/forget_password/controllers/forget_password_controller.dart';

import '../../../../core/constants/app_assets.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forget Password",
          style: TextStyle(color: AppColor.kFont),
        ),
        iconTheme: const IconThemeData(color: AppColor.kFont),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSize.sidePadding),
            child: Column(
              children: [
                SvgPicture.asset(
                  AppAssets.kforget,
                  width: 250,
                ),
                const Text(
                  "Enter your email address associated with your account we will send you a link to reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Form(
                  key: controller.formKey,
                  child: CustomTextField(
                    labelText: "Email Address",
                    controller: controller.email,
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
                ),
                const SizedBox(height: 20),
                AppButton(
                  color: AppColor.kBlue,
                  titleColor: Colors.white,
                  title: "Submit",
                  onTap: controller.submit,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

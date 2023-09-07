import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_color.dart';

class LoadingHelper {
  static showLoading() {
    Get.dialog(
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetPlatform.isAndroid
                ? const CircularProgressIndicator(color: AppColor.kBlue)
                : const CupertinoActivityIndicator(color: AppColor.kBlue)
          ],
        ),
      ),
      barrierDismissible: false,
      useSafeArea: true,
      barrierColor: Colors.white.withOpacity(0.5),
    );
  }

  static hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}

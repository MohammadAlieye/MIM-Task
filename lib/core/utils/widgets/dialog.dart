import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task/core/constants/app_assets.dart';
import 'package:task/core/constants/app_color.dart';

import '../fonts/fonts.dart';

class AppDialog {
  Future showOSDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? firstButtonText,
    VoidCallback? firstCallBack,
    required String secondButtonText,
    required VoidCallback secondCallBack,
    bool? isHost,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: CustomDialog(
              title: title,
              description: message,
              firstButtonText: firstButtonText ?? "",
              firstCallback: firstCallBack ?? Get.back,
              secondButtonText: secondButtonText,
              secondCallback: secondCallBack,
            ));
      },
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, firstButtonText, secondButtonText;
  final VoidCallback firstCallback, secondCallback;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.firstCallback,
    required this.secondCallback,
    required this.firstButtonText,
    required this.secondButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(title,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style:
                            StyleRefer.kgilroyExtraBold.copyWith(fontSize: 20)),
                  ),
                  InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: SvgPicture.asset(AppAssets.crossIcon),
                      ))
                ],
              ),
              const SizedBox(height: 24),
              Text(description,
                  style: StyleRefer.kGilroy
                      .copyWith(fontSize: 16, overflow: TextOverflow.visible)),
              const SizedBox(height: 33),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: firstButtonText.isNotEmpty,
                    child: MaterialButton(
                      splashColor: Colors.transparent,
                      onPressed: firstCallback,
                      child: Text(
                        firstButtonText,
                        softWrap: true,
                        style: StyleRefer.kgilroyExtraBold
                            .copyWith(color: AppColor.kBlue),
                      ),
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    splashColor: Colors.transparent,
                    elevation: 0,
                    disabledElevation: 0,
                    onPressed: secondCallback,
                    color: AppColor.kBlue,
                    child: Text(
                      secondButtonText,
                      style: StyleRefer.kgilroyExtraBold
                          .copyWith(color: AppColor.white),
                    ),
                  )
                ],
              )
            ]),
      ),
    );
  }
}

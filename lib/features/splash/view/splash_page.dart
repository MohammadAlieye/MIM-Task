import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/app_assets.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          AppAssets.animationJSON,
          controller: animationController,
          onLoaded: (composition) {
            animationController
              ..duration = const Duration(seconds: 3)
              ..forward();
          },
          width: Get.width * 0.8,
        ),
      ),
    );
  }
}

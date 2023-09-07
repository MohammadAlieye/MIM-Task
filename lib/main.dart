import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:task/core/constants/app_assets.dart';
import 'package:task/features/home/profile/profile/profile_controller.dart';
import 'core/services/notification/push_notification.dart';
import 'features/splash/view/splash_page.dart';
import 'package:timezone/data/latest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeTimeZones();
  await PushNotificationService().listenNotifications();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());

    precacheImage(const AssetImage(AppAssets.logoJPG), context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Obx(() => GetMaterialApp(
            title: 'Task',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: profileController.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const SplashView(),
          )),
    );
  }
}

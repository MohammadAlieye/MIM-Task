import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/features/home/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        body: controller.body,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          currentIndex: controller.index,
          useLegacyColorScheme: true,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: controller.onTapNav,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_on),
              label: "",
            ),
           
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "",
            ),
          ],
        ),
        
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_size.dart';
import 'package:task/core/utils/widgets/buttons.dart';
import 'package:task/features/home/profile/profile/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile and Settings"),
       
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSize.sidePadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                InkWell(
                  onTap: () => controller.showBottomSheet(context),
                  child: Stack(
                    children: [
                      Obx(() {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: controller.photoUrl.value.isNotEmpty
                                ? SizedBox(
                                    width: 95,
                                    height: 95,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: CachedNetworkImage(
                                          placeholder: (context, s) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: AppColor
                                                              .kBlue)),
                                          imageUrl:
                                              controller.photoUrl.value,
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : SvgPicture.asset(
                                    'assets/images/person.svg',
                                    width: 95,
                                    height: 95,
                                    fit: BoxFit.fill,
                                  ),
                          );},),
                      Padding(
                        padding: const EdgeInsets.only(left: 65, top: 60),
                        child: Material(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          elevation: 3,
                          child: Container(
                            alignment: Alignment.center,
                            width: 30,
                            height: 30,
                            child: SvgPicture.asset(
                              'assets/images/cameraFill.svg',
                              width: 16,
                              height: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                
ListTile(
            title: Text('Dark Mode'),
            trailing: Obx(
            () => Switch(
              value: controller.isDarkMode.value,
              onChanged: (newValue) {
                controller.toggleDarkMode();
              },
            ),
            ),
          ),
          ListTile(
            title: const Text('Receive Notifications'),
            trailing: Obx(
            () => Switch(
              value: controller.receiveNotifications.value,
              onChanged: (newValue) {
                controller.toggleNotifications();
              },
            ),
            ),
          ),

                const SizedBox(height: 50),
                AppButton(
                  color: AppColor.kBlue,
                  titleColor: AppColor.white,
                  title: "Sign out",
                  onTap: ()  {
                    controller.signOut();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

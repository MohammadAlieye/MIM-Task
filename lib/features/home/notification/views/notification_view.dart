import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/services/notification/push_notification.dart';
import '../../../../core/constants/app_color.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.width * 0.5,
              width: Get.width * 0.5,
              child: MaterialButton(
                onPressed: _notification,
                shape: const CircleBorder(),
                color: Colors.red,
                child: const Text(
                  "Send Notification",
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          SizedBox(
                  height: Get.width * 0.5,
                  width: Get.width * 0.5,
                  child: MaterialButton(
                    onPressed: (){_scheduleNotification(context);},
                    shape: const CircleBorder(),
                    color: AppColor.kBlue,
                    child:  const Text(
                       "Schedule Notification ",
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
               ),
          ],
        ),
      ),
    );
  }

  void _notification() {
    PushNotificationService().showNotification(
      "Congratulations! 🎉",
      "You recived the notification",
    );
  }

  void _scheduleNotification(BuildContext context) {
    PushNotificationService().zonedScheduleNotification(context);}
}

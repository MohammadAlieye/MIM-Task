import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {

    Rx<TimeOfDay>? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime!.value,
    );
    if (picked != null && picked != selectedTime!.value) {
      selectedTime!.value = picked;
    }
  }

}

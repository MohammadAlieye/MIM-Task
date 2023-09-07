import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/features/home/listView/list_view.dart';
import 'package:task/features/home/profile/views/profile_view.dart';

import 'notification/views/notification_view.dart';
import 'text/views/text_view.dart';

class HomeController extends GetxController {
  int _index = 0;

  int get index => _index;
  Widget get body => _body();
  onTapNav(int value) => _onTapNav(value);

  void _onTapNav(int value) {
    _index = value;
    update();
  }

  Widget _body() {
    switch (_index) {
      case 0:
        return const NotificationView();
      case 1:
        return const ListViewScreen();
      case 2:
        return const TextView();
      case 3:
        return const ProfileView();
      default:
        return const NotificationView();
    }
  }
}

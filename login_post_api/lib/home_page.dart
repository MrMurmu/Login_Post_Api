import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_post_api/Auth/login_page.dart';
import 'package:login_post_api/Services/GetX/auth_controller.dart';
import 'package:login_post_api/Services/Model/user_model.dart';
import 'package:login_post_api/profile_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final box = GetStorage();
    bool isLoggedIn = box.read('isLoggedIn') ?? false;

    // Navigate to the appropriate page based on login state
    if (isLoggedIn && authController.user.value == null) {
      final userData = box.read('user');
      if (userData != null) {
        authController.user.value = UserModelModel.fromMap(Map<String, dynamic>.from(userData));
      }
    }

    final user = authController.user.value;

    return isLoggedIn && user != null
        ? ProfilePage(user: user)
        : LoginPage();
  }
}
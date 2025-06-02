import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:login_post_api/Auth/login_page.dart';
import 'package:login_post_api/Services/GetX/auth_controller.dart';
import 'package:login_post_api/profile_page.dart';

class AuthClass {
  final AuthController authController = Get.find<AuthController>();
  final box = GetStorage();

  Future<void> login(String email, String password) async {
    bool success = await authController.login(email, password);
    if (success && authController.user.value != null) {
      box.write('isLoggedIn', true);
      Get.snackbar("Success", "Login successful");
      Get.to(() => ProfilePage(user: authController.user.value!));
    } else {
      Get.snackbar("Error", "Login failed");
    }
  }

  void _logout() {
    final box = GetStorage();
    final authController = Get.find<AuthController>();
    box.erase(); // clear storage
    authController.user.value = null; // reset user
    Get.offAll(() => const LoginPage()); // navigate to login and remove backstack
  }
}

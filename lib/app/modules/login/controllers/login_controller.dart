import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/auth_utils.dart';

class LoginController extends GetxController {
  final errorMessage = ''.obs;
  final isObscure = true.obs;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void toggleObscure() => isObscure.value = !isObscure.value;

  Future<void> login() async {
    errorMessage.value = '';
    final user = usernameController.text.trim();
    final pass = passwordController.text.trim();
    if (user.isEmpty || pass.isEmpty) {
      errorMessage.value = '请输入用户名和密码';
      return;
    }
    await AuthUtils.setLoggedIn(true);
    Get.offAllNamed(Routes.MAIN);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

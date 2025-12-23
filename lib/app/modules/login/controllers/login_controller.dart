import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/auth_utils.dart';

class LoginController extends GetxController {
  final tabIndex = 0.obs;
  final errorMessage = ''.obs;
  final isObscure = true.obs;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final phoneController = TextEditingController();
  final codeController = TextEditingController();

  void setTab(int index) => tabIndex.value = index;

  void toggleObscure() => isObscure.value = !isObscure.value;

  Future<void> login() async {
    errorMessage.value = '';
    if (tabIndex.value == 0) {
      final user = usernameController.text.trim();
      final pass = passwordController.text.trim();
      if (user.isEmpty || pass.isEmpty) {
        errorMessage.value = '请输入用户名和密码';
        return;
      }
    } else {
      final phone = phoneController.text.trim();
      final code = codeController.text.trim();
      if (phone.isEmpty || code.isEmpty) {
        errorMessage.value = '请输入手机号和验证码';
        return;
      }
    }
    await AuthUtils.setLoggedIn(true);
    Get.offAllNamed(Routes.MAIN);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    codeController.dispose();
    super.onClose();
  }
}

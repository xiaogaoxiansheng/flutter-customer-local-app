import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/auth_utils.dart';

class ChangeLanguageController extends GetxController {
  final selectedLocale = const Locale('zh', 'CN').obs;

  void selectChinese() => selectedLocale.value = const Locale('zh', 'CN');

  void selectEnglish() => selectedLocale.value = const Locale('en', 'US');

  Future<void> confirm() async {
    Get.updateLocale(selectedLocale.value);
    final loggedIn = AuthUtils.isLoggedIn();
    if (loggedIn) {
      Get.offAllNamed(Routes.main);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}

import 'package:get/get.dart';

import '../controllers/change_language_controller.dart';

class ChangeLanguageBinding extends Bindings {
  @override
  void dependencies() {
    // 【AI修改】 注册 ChangeLanguageController
    Get.lazyPut<ChangeLanguageController>(() => ChangeLanguageController());
  }
}

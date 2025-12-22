import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // 【AI修改】 注册 RegisterController
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}

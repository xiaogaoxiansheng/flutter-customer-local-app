import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    //注册 LoginController
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

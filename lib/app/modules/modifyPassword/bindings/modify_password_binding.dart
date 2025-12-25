import 'package:get/get.dart';

import '../controllers/modify_password_controller.dart';

/// 修改密码页绑定
/// 负责将控制器注入到依赖系统中
class ModifyPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModifyPasswordController>(() => ModifyPasswordController());
  }
}


import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../device/controllers/device_controller.dart';
import '../../alarm/controllers/alarm_controller.dart';
import '../../my/controllers/my_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
    // 注入子页面控制器
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DeviceController>(() => DeviceController());
    Get.lazyPut<AlarmController>(() => AlarmController());
    Get.lazyPut<MyController>(() => MyController());
  }
}

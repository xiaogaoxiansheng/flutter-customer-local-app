import 'package:get/get.dart';

import '../controllers/device_controller.dart';

class DeviceBinding extends Bindings {
  @override
  void dependencies() {
    //注册 DeviceController
    Get.lazyPut<DeviceController>(() => DeviceController());
  }
}

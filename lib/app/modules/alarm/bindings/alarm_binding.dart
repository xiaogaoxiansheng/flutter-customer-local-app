import 'package:get/get.dart';

import '../controllers/alarm_controller.dart';

class AlarmBinding extends Bindings {
  @override
  void dependencies() {
    //注册 AlarmController
    Get.lazyPut<AlarmController>(() => AlarmController());
  }
}

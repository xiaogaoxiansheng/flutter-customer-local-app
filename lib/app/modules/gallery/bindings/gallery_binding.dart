import 'package:get/get.dart';

import '../controllers/gallery_controller.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    // 【AI修改】 注册 GalleryController
    Get.lazyPut<GalleryController>(() => GalleryController());
  }
}

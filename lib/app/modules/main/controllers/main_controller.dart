import 'package:get/get.dart';

class MainController extends GetxController {
  // 当前 Tab 索引
  final currentIndex = 3.obs;

  // 切换 Tab
  void changePage(int index) {
    currentIndex.value = index;
  }
}

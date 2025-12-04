import 'package:get/get.dart';
// 【AI修改】引入全局日志工具
import 'package:flutter_customer_local_app/app/utils/appLogger.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  // 【AI修改】保存 workers，便于在 onClose 统一释放
  final List<Worker> _workers = [];
  @override
  void onInit() {
    super.onInit();
    // 【AI修改】每次 count 改变都回调
    _workers.add(ever<int>(count, (v) {
      AppLogger.d('ever: count changed -> $v');
    }));

    // 【AI修改】首次改变时回调一次
    _workers.add(once<int>(count, (v) {
      AppLogger.i('once: first change -> $v');
    }));

    // 【AI修改】防抖：停止变化 500ms 后回调
    _workers.add(debounce<int>(count, (v) {
      AppLogger.w('debounce: settled -> $v');
    }, time: const Duration(milliseconds: 500)));

    // 【AI修改】节流：按 1s 间隔回调
    _workers.add(interval<int>(count, (v) {
      AppLogger.t('interval: tick -> $v');
    }, time: const Duration(seconds: 1)));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // 【AI修改】释放所有 workers，防止泄漏
    for (final w in _workers) {
      w.dispose();
    }
    _workers.clear();
    super.onClose();
  }

  void increment() => count.value++;
}

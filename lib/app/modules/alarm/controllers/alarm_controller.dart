import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../views/scan_view.dart';

class AlarmController extends GetxController {
  final selectedTabIndex = 0.obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void selectTab(int index) => selectedTabIndex.value = index;

  Future<void> scanBarcode() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final result = await Get.to(() => const ScanView());
      if (result != null && result is String) {
        searchController.text = result;
      }
    } else {
      Get.snackbar('权限不足', '请授予相机权限以进行扫码',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/device_details_controller.dart';

class DeviceDetailsView extends GetView<DeviceDetailsController> {
  const DeviceDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeviceDetails'),
        centerTitle: true,
      ),
      // 【AI修改】 设备详情页占位视图
      body: const Center(
        child: Text('DeviceDetails Page'),
      ),
    );
  }
}

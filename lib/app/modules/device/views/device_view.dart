import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/device_controller.dart';

class DeviceView extends GetView<DeviceController> {
  const DeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device'),
        centerTitle: true,
      ),
      //设备列表页占位视图
      body: const Center(
        child: Text('Device Page'),
      ),
    );
  }
}

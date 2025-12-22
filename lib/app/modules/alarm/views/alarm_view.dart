import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/alarm_controller.dart';

class AlarmView extends GetView<AlarmController> {
  const AlarmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm'),
        centerTitle: true,
      ),
      // 【AI修改】 告警页占位视图
      body: const Center(
        child: Text('Alarm Page'),
      ),
    );
  }
}

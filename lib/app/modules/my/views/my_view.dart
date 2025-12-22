import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/my_controller.dart';

class MyView extends GetView<MyController> {
  const MyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My'),
        centerTitle: true,
      ),
      // 【AI修改】 我的页占位视图
      body: const Center(
        child: Text('My Page'),
      ),
    );
  }
}

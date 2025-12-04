import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      // 【AI修改】改为使用 GetX 自动依赖收集并监听响应式 count
      body: Center(
        child: GetX<HomeController>(
          builder: (data) => Text(
            'HomeView is working ${data.count.value}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      // 【AI修改】添加交互按钮，点击递增 count
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

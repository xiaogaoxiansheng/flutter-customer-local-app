import 'package:flutter/material.dart';

import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
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
      // 【AI修改】 使用 ConstraintLayout 替换 Center 布局
      body: ConstraintLayout(
        children: [
          const Text(
            'HomeView is working',
            style: TextStyle(fontSize: 20),
          ).applyConstraint(
            // 【AI修改】 设置约束ID
            id: ConstraintId('text'),
            // 【AI修改】 将文本组件居中显示
            centerTo: parent,
          ),
        ],
      ),
    );
  }
}

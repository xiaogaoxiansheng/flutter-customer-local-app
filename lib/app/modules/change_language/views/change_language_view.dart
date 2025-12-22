import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/change_language_controller.dart';

class ChangeLanguageView extends GetView<ChangeLanguageController> {
  const ChangeLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeLanguage'),
        centerTitle: true,
      ),
      // 【AI修改】 选择语言页占位视图
      body: const Center(
        child: Text('ChangeLanguage Page'),
      ),
    );
  }
}

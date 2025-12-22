import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/gallery_controller.dart';

class GalleryView extends GetView<GalleryController> {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        centerTitle: true,
      ),
      // 【AI修改】 图库页占位视图
      body: const Center(
        child: Text('Gallery Page'),
      ),
    );
  }
}

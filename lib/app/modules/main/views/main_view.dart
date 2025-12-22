import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';
import '../../home/views/home_view.dart';
import '../../device/views/device_view.dart';
import '../../alarm/views/alarm_view.dart';
import '../../my/views/my_view.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用 IndexedStack 保持页面状态
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: const [
              HomeView(),
              DeviceView(),
              AlarmView(),
              MyView(),
            ],
          )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          type: BottomNavigationBarType.fixed, // 固定类型，显示所有标签
          selectedItemColor: Colors.green, // 选中颜色
          unselectedItemColor: Colors.grey, // 未选中颜色
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.devices),
              label: '设备',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning),
              label: '告警',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '我',
            ),
          ],
        ),
      ),
    );
  }
}

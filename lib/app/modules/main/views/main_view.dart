import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './main_styles.dart';
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
      backgroundColor: Colors.white,
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
        () => SafeArea(
          top: false,
          child: Container(
            color: MainStyles.bottomBackground,
            child: SizedBox(
              height: MainStyles.bottomNavHeight(),
              child: BottomNavigationBar(
                backgroundColor: MainStyles.bottomBackground,
                elevation: 0,
                currentIndex: controller.currentIndex.value,
                onTap: controller.changePage,
                type: BottomNavigationBarType.fixed, // 固定类型，显示所有标签
                selectedItemColor: MainStyles.selectedColor,
                unselectedItemColor: MainStyles.unselectedColor,
                items: MainStyles.bottomNavItems(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

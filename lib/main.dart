import 'package:flutter/material.dart';

import 'package:get/get.dart';
// 【AI修改】全局封装导入
import 'utils/appLogger.dart';
import 'utils/screenUtil.dart';

import 'app/routes/app_pages.dart';

void main() {
  // 【AI修改】初始化绑定与日志
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.init();

  // 【AI修改】集成屏幕适配
  runApp(
    screenUtilInit(
      app: GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/translations/app_translations.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // 【AI修改】 配置多语言
      translations: AppTranslations(),
      locale: const Locale('zh', 'CN'), // 默认语言
      fallbackLocale: const Locale('en', 'US'), // 备用语言
    ),
  );
}

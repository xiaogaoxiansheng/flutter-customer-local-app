import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/routes/app_pages.dart';
import 'app/translations/app_translations.dart';
import 'app/utils/auth_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 【AI修改】 初始化本地存储并读取登录状态
  await AuthUtils.init();

  runApp(
    ScreenUtilInit(
      designSize: const Size(750, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: "Application",
        initialRoute: Routes.CHANGE_LANGUAGE,
        getPages: AppPages.routes,
        translations: AppTranslations(),
        locale: const Locale('zh', 'CN'),
        fallbackLocale: const Locale('en', 'US'),
      ),
    ),
  );
}

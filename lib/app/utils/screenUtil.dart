import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 【AI修改】统一屏幕适配初始化
Widget screenUtilInit({
  required Widget app,
  Size designSize = const Size(375, 812),
}) => ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => app,
    );


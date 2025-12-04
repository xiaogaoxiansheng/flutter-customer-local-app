// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// 【AI修改】替换默认示例测试，适配 GetX 初始化路由与 HomeView
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:flutter_customer_local_app/app/routes/app_pages.dart';

void main() {
  testWidgets('渲染 HomeView 文本', (WidgetTester tester) async {
    // 【AI修改】使用与 main.dart 一致的 GetMaterialApp 配置
    await tester.pumpWidget(
      GetMaterialApp(
        title: 'Application',
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );

    // 【AI修改】断言 HomeView 的核心文案存在
    expect(find.text('HomeView is working'), findsOneWidget);
  });
}

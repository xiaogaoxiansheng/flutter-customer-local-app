# flutter_customer_local_app

【AI修改】以下为本项目的开发与运行环境版本说明（含最低/最高支持）：

## 开发环境
- 操作系统：Windows 11 24H2 及以上（开发验证环境）
- IDE：Android Studio 2024.2 或 VS Code 最新稳定版
- 设备：Android 13（API 33）及以上已验证

## Flutter/Dart
- Flutter 版本：3.29.0（稳定分支，已验证）
- Dart 版本：3.7.0（由 Flutter 3.29.0 提供）
- 最低支持：Flutter 3.27.0 / Dart 3.7.0
- 最高支持：Flutter 3.29.x（稳定版）/ Dart 3.7.x
- 注意：使用 ASCII 路径安装 Flutter SDK，避免 Gradle 解析失败（已在 `android/local.properties` 配置为 `C:\flutter_sdk_329`）。

## Android 构建链
- Gradle（Wrapper）：8.10.2（来源：`android/gradle/wrapper/gradle-wrapper.properties:5`）
- Android Gradle Plugin（AGP）：8.7.0（来源：`android/settings.gradle.kts:21`、`android/build.gradle.kts:1`）
- Kotlin Gradle Plugin：1.8.22（来源：`android/settings.gradle.kts:22`）
- JDK（运行 Gradle）：21.0.4（建议使用 Android Studio 自带 JBR，`C:\Program Files\Android\Android Studio1\jbr`）
- Java 源/目标兼容级别：Java 11（来源：`android/app/build.gradle.kts:13-16`，JDK 可为 17/21）
- Android SDK：Build-Tools 35.0.1 / Platform android-36（来自 `flutter doctor -v`）
- 最低/最高支持建议：
  - Gradle：最低 8.9，最高 8.10.2（与 AGP 8.7 兼容）
  - AGP：固定为 8.7.x（本项目已锁定 8.7.0）
  - Kotlin：固定为 1.8.22（与 AGP 配置一致）
  - JDK：最低 17，最高 21（推荐 21）
  - Build-Tools：最低 35.0.0，最高 35.x

## Android 应用配置（来自模板）
- `compileSdk`：由 Flutter Gradle 插件提供（当前 Flutter 3.29 默认为 35）
- `targetSdk`：由 Flutter Gradle 插件提供（当前默认为 35）
- `minSdk`：由 Flutter Gradle 插件提供（当前默认为 21）
- 参考位置：
  - `android/app/build.gradle.kts:10`（`compileSdk = flutter.compileSdkVersion`）
  - `android/app/build.gradle.kts:27-28`（`minSdk/targetSdk = flutter.*`）

## 版本策略与兼容性
- 本项目已在 Flutter 3.29.0 / Dart 3.7.0 / AGP 8.7.0 / Gradle 8.10.2 / JDK 21.0.4 环境完整验证（构建与运行）。
- 为避免构建失败：
  - 请确保 `JAVA_HOME` 指向 ASCII 路径的 JDK（推荐 Android Studio JBR）。
  - 确保 `flutter.sdk` 为 ASCII 路径（示例：`C:\flutter_sdk_329`）。
  - 避免将 SDK 安装在包含空格或非 ASCII 字符的路径中。

## 运行提示
- 常用命令：
  - `& 'C:\flutter_sdk_329\bin\flutter.bat' run -d <device> --debug`
  - `flutter test -r compact`
- 若遇到 Gradle 插件加载错误，请执行：
  - `flutter clean` 后重试；
  - 检查并修复 `android/local.properties` 的 `flutter.sdk` 路径。

【AI修改】以上信息会随依赖升级而调整，请以 `flutter doctor -v` 与项目 `android` 目录下的 Gradle/Kotlin/AGP 配置为准。

【AI修改】## 项目目录结构
【AI修改】- 顶层目录：
【AI修改】  - `lib/` 应用源码（入口与路由、模块化代码）
【AI修改】  - `android/`、`ios/`、`macos/`、`linux/`、`windows/` 平台工程
【AI修改】  - `web/` Web 构建资源（`index.html`、PWA `manifest.json` 等）
【AI修改】  - `test/` 单元/组件测试样例（`widget_test.dart`）
【AI修改】  - `pubspec.yaml` 依赖与资源声明
【AI修改】  - `analysis_options.yaml` Dart/Flutter Lints 配置
【AI修改】- `lib/` 关键结构：
【AI修改】  - `lib/main.dart` 应用入口，使用 `GetMaterialApp` 进行路由注册（lib/main.dart:7-14）
【AI修改】  - `lib/app/routes/` 路由定义：
【AI修改】    - `app_pages.dart` 声明 `AppPages.routes` 与初始路由（lib/app/routes/app_pages.dart:11-19）
【AI修改】    - `app_routes.dart` 路径常量（lib/app/routes/app_routes.dart:4-12）
【AI修改】  - `lib/app/modules/home/` Home 模块：
【AI修改】    - `bindings/home_binding.dart` 依赖注入（Get.lazyPut）（lib/app/modules/home/bindings/home_binding.dart:5-11）
【AI修改】    - `controllers/home_controller.dart` 控制器与响应式状态 `count`（lib/app/modules/home/controllers/home_controller.dart:3-22）
【AI修改】    - `views/home_view.dart` 视图骨架（Scaffold/AppBar/Body）（lib/app/modules/home/views/home_view.dart:7-22）

【AI修改】## 依赖与插件（来自 `pubspec.yaml`）
【AI修改】- 运行时依赖：
【AI修改】  - `get: ^4.7.3` 路由/DI/响应式（GetX）
【AI修改】  - `cupertino_icons: ^1.0.8` iOS 风格图标集
【AI修改】- 开发/测试依赖：
【AI修改】  - `flutter_test` Flutter 官方测试包
【AI修改】  - `flutter_lints: ^5.0.0` 官方推荐代码规范检查

【AI修改】## 已实现功能概览
【AI修改】- 路由与应用骨架：
【AI修改】  - 使用 `GetMaterialApp` 注册页面与初始路由（`Routes.HOME`）（lib/main.dart:7-14）
【AI修改】  - 路由表采用 `GetPage` 进行页面与绑定关联（lib/app/routes/app_pages.dart:13-19）
【AI修改】- 模块化结构（Home 模块）：
【AI修改】  - 绑定层：通过 `HomeBinding` 懒加载控制器实例（lib/app/modules/home/bindings/home_binding.dart:5-11）
【AI修改】  - 控制器层：提供响应式计数 `count` 与 `increment` 方法（lib/app/modules/home/controllers/home_controller.dart:6,22）
【AI修改】  - 视图层：基础页面框架与占位文案（lib/app/modules/home/views/home_view.dart:11-22）
【AI修改】- 多平台工程：已生成 Android/iOS/Web/Windows/macOS/Linux 工程骨架，可直接运行与构建（各平台对应目录）
【AI修改】- 测试与规范：包含示例组件测试 `test/widget_test.dart` 与 lints 配置

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

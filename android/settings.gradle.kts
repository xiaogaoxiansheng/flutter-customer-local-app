pluginManagement {
    var flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    // 【AI修改】当路径包含非 ASCII 字符或不可用时，回退到 ASCII 路径联接
    val containsNonAscii = flutterSdkPath.any { it.code > 127 }
    val gradleDir = java.io.File("$flutterSdkPath/packages/flutter_tools/gradle")
    if (containsNonAscii || !gradleDir.exists()) {
        val fallback = System.getenv("FALLBACK_FLUTTER_SDK") ?: "C:\\flutter_sdk_329"
        println("【AI修改】检测到 flutterSdkPath 包含非 ASCII 或不存在，回退到: $fallback")
        flutterSdkPath = fallback
    }

    // 【AI修改】调试输出最终使用的 Flutter SDK 路径
    println("【AI修改】flutterSdkPath=" + flutterSdkPath)

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.0" apply false
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false
}

include(":app")
